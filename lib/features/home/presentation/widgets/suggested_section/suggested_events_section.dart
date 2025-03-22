import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';

class SuggestedEventsListView extends StatelessWidget {
  const SuggestedEventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItem),
        child: EventCard(),
      ),
    );
  }
}
