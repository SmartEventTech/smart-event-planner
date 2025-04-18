import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';

class FilterEventsList extends StatelessWidget {
  const FilterEventsList({super.key, required this.events});

  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(
          title: Text(event.title ?? 'No Title'),
          subtitle: Text('${event.description}\n${event.location}'),
          isThreeLine: true,
        );
      },
    );
  }
}
