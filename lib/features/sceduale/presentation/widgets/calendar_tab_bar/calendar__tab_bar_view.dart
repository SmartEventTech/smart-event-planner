import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/sceduale/presentation/widgets/calendar_tab_bar/calender_section.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';

class CalendarTabBarView extends StatelessWidget {
  const CalendarTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AppSizes.defaultScreenPadding,
        left: AppSizes.defaultScreenPadding,
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: AppSizes.sm)),
          SliverToBoxAdapter(
            child: CalenderSection(
              onFocusDay: (focusedDay) {},
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 2,
              color: AppColors.dividerColor,
              height: AppSizes.dividerHeight,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.defaultPadding),
          ),
          const SliverFillRemaining(
            child: EventsListView(
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
