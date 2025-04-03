import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';

class EventsListView extends StatelessWidget {
  const EventsListView(
      {super.key, this.physics, this.editCard = false, this.events});
  final ScrollPhysics? physics;
  final bool editCard;
  final List<EventModel>? events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: events?.length ?? 6,
      padding: const EdgeInsets.only(top: 0),
      physics: physics,
      itemBuilder: (context, index) => EventCard(
        editCard: editCard,
        event: events?[index],
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
    );
  }
}
