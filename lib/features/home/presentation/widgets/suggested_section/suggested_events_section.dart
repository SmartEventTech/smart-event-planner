import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';

class SuggestedEventsSection extends StatelessWidget {
  const SuggestedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItem),
          child: EventCard(),
        ),
        childCount: 4,
      ),
    );
  }
}
