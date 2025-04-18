import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';

class SuggestedEventsListView extends StatelessWidget {
  final List<EventModel> events;

  const SuggestedEventsListView({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: EventCard(
          event: events[index],
      
        ),
      ),
      itemCount: events.length,
    );
  }
}