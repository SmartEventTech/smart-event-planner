import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/events/event_card.dart';

class FilterEventsList extends StatelessWidget {
  const FilterEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: 6,
        itemBuilder: (context, index) => EventCard(),
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSizes.spaceBtwItem),
      ),
    );
  }
}
