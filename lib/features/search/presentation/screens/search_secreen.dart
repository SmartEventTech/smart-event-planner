import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/services/event_service.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';
import 'package:smart_event_planner/features/search/presentation/screens/custom_drawer.dart';
import 'package:smart_event_planner/features/search/presentation/widget/screen_search_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final EventService _eventService = EventService();

  List<EventModel> allEvents = [];
  List<EventModel> filteredEvents = [];
  List<String> selectedCategories = [];
  String searchQuery = '';
  bool isLoading = true;
  String errorMessage = '';
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _loadInitialData() async {
    try {
      final events = await _eventService.getEvents();
      setState(() {
        allEvents = events;
        filteredEvents = events;
        isLoading = false;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() => isRefreshing = true);
    try {
      final events = await _eventService.getEvents();
      setState(() {
        allEvents = events;
        filteredEvents = events;
        isRefreshing = false;
        errorMessage = '';
      });
      _applyFilters();
    } catch (e) {
      setState(() {
        isRefreshing = false;
        errorMessage = e.toString();
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = _searchController.text.trim().toLowerCase();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      filteredEvents = allEvents.where((event) {
        final title = event.title?.toLowerCase() ?? '';
        final description = event.description?.toLowerCase() ?? '';
        final locationName = event.location?.name?.toLowerCase() ?? '';
        final category = event.category ?? '';

        final matchesSearch = searchQuery.isEmpty ||
            title.contains(searchQuery) ||
            description.contains(searchQuery) ||
            locationName.contains(searchQuery);

        final matchesCategories =
            selectedCategories.isEmpty || selectedCategories.contains(category);

        return matchesSearch && matchesCategories;
      }).toList();
    });
  }

  void _onCategoriesSelected(List<String> categories) {
    setState(() {
      selectedCategories = categories;
      _applyFilters();
    });
  }

  void _clearAllFilters() {
    setState(() {
      selectedCategories.clear();
      _searchController.clear();
      filteredEvents = allEvents;
    });
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _refreshData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoEventsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 50, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "No events found",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          if (searchQuery.isNotEmpty || selectedCategories.isNotEmpty)
            TextButton(
              onPressed: _clearAllFilters,
              child: const Text('Clear all filters'),
            ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        final event = filteredEvents[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.paidEventScreen,
                arguments: event,
              );
            },
            child: EventCard(event: event),
          ),
        );
      },
    );
  }

  Widget _buildActiveFiltersChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedCategories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              label: Text(selectedCategories[index]),
              onDeleted: () {
                setState(() {
                  selectedCategories.removeAt(index);
                  _applyFilters();
                });
              },
              deleteIconColor: AppColors.primaryColor,
              backgroundColor: AppColors.lightScaffoldBgColor,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(
        events: allEvents,
        onFiltersSelected: _onCategoriesSelected,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            SearchScreenHeader(
              controller: _searchController,
              onFilterButtonPressed: () =>
                  _scaffoldKey.currentState?.openEndDrawer(),
              activeFilters: selectedCategories,
              onClearFilters: _clearAllFilters,
            ),
            const SizedBox(height: 0),
            if (selectedCategories.isNotEmpty) ...[
              _buildActiveFiltersChips(),
              const SizedBox(height: 8),
            ],
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? _buildErrorWidget()
                      : RefreshIndicator(
                          onRefresh: _refreshData,
                          child: filteredEvents.isEmpty
                              ? _buildNoEventsWidget()
                              : _buildEventList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
