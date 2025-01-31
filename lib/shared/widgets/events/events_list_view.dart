import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, this.physics});
  final ScrollPhysics? physics;
  // itemCount
  // listOfEvents
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      padding: const EdgeInsets.only(top: 0),
      physics: physics,
      itemBuilder: (context, index) => EventCard(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItem),
    );
  }
}
