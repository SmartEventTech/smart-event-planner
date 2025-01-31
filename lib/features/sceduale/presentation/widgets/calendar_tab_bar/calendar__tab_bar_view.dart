import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/sceduale/presentation/widgets/calendar_tab_bar/calender_section.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';

class CalendarTabBarView extends StatelessWidget {
  const CalendarTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSizes.sm),
        CalenderSection(
          onFocusDay: (focusedDay) {},
        ),
        //const SizedBox(height: AppSizes.spaceBtwSection),
        // Text(
        //   focusedDay.toFormattedFullDate(),
        //   style: AppTextStyle.textStyle16Bold,
        // ),
        Divider(
          thickness: 2,
          color: AppColors.dividerColor,
          height: AppSizes.dividerHeight,
        ),
        const SizedBox(height: AppSizes.defaultPadding),
        Expanded(
          child: EventsListView(physics: NeverScrollableScrollPhysics()),
        ),
      ],
    );
  }
}
