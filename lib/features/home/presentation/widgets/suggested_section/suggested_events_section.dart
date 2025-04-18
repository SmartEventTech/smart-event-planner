import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';

class SuggestedEventsSection extends StatelessWidget {
  final List<EventModel> events;

  const SuggestedEventsSection({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(
            bottom: AppSizes.spaceBtwItems,
            right: AppSizes.defaultScreenPadding,
            left: AppSizes.defaultScreenPadding,
          ),
          child: EventCard(
            event: events[index],
        
          ),
        ),
        childCount: events.length,
      ),
    );
  }
}
