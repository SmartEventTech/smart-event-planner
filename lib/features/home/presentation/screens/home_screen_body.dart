import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/shared/widgets/sections/section_heading.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/create_event_section.dart';
import 'package:smart_event_planner/core/services/event_service.dart'; // افترضنا أن لديك خدمة للـ API
import 'package:smart_event_planner/features/home/presentation/widgets/interested_section/interests_section.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/suggested_section/suggested_events_list_view.dart';
// ignore_for_file: unused_field


class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  late Future<List<EventModel>> _eventsFuture;
  bool _isLoading = true;
  List<EventModel> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      setState(() => _isLoading = true);
      final eventService = EventService();
      final events = await eventService.getEvents(); 
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultScreenPadding,
        vertical: AppSizes.sm,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.defaultBorderRadius),
          topRight: Radius.circular(AppSizes.defaultBorderRadius),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const CreateEventSection(),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  SectionHeading(
                    title: 'Interests',
                    btnTitle: 'View All',
                    onPressed: () async {},
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  const InterestsSection(),
                  SectionHeading(
                    title: 'Events you might like',
                    btnTitle: 'View All',
                    onPressed: () async {},
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                ],
              ),
            ),
            if (_isLoading)
              const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_events.isEmpty)
              const SliverToBoxAdapter(
                child: Center(child: Text('No events available')),
              )
            else
              SuggestedEventsListView(events: _events),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSizes.spaceBtwItems),
            ),
          ],
        ),
      ),
    );
  }
}