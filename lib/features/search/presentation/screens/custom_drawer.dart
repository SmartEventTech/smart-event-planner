import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';

class CustomDrawer extends StatefulWidget {
  final List<EventModel> events;
  final Function(List<String>) onFiltersSelected;

  const CustomDrawer({
    super.key,
    required this.events,
    required this.onFiltersSelected,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<String> selectedCategories = [];

  List<String> _getUniqueCategories() {
    return widget.events
        .map((e) => e.category)
        .whereType<String>()
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList()
        ..sort();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getUniqueCategories();

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.50,
      child: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            'Filter Events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CheckboxListTile(
                  title: Text(category),
                  value: selectedCategories.contains(category),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedCategories.add(category);
                      } else {
                        selectedCategories.remove(category);
                      }
                    });
                  },
                  activeColor: AppColors.primaryColor,
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    setState(() => selectedCategories.clear());
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.clear_rounded),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    widget.onFiltersSelected(selectedCategories);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.check_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}