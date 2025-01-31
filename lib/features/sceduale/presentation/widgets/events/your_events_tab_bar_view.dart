import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';

class YourEventsTabBarView extends StatelessWidget {
  const YourEventsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.slg),
      child: EventsListView(),
    );
  }
}
