import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/sceduale/presentation/widgets/calendar_tab_bar/calender_section.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';

class CalendarTabBarView extends StatelessWidget {
  const CalendarTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: const SizedBox(height: AppSizes.sm)),
        SliverToBoxAdapter(
          child: CalenderSection(
            onFocusDay: (focusedDay) {},
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(
            thickness: 2,
            color: AppColors.dividerColor,
            height: AppSizes.dividerHeight,
          ),
        ),
        SliverToBoxAdapter(
            child: const SizedBox(height: AppSizes.defaultPadding)),
        SliverFillRemaining(
          child: EventsListView(physics: NeverScrollableScrollPhysics()),
        ),
      ],
    );
  }
}
