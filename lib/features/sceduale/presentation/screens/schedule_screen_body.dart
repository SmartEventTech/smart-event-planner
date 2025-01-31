import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
import 'package:smart_event_planner/features/sceduale/presentation/widgets/calendar_tab_bar/calendar__tab_bar_view.dart';
import 'package:smart_event_planner/features/sceduale/presentation/widgets/events/your_events_tab_bar_view.dart';

class ScheduleScreenBody extends StatelessWidget {
  const ScheduleScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const SizedBox(height: AppSizes.sm),
          TabBar(
            labelStyle: AppTextStyle.textStyle16Bold,
            dividerColor: Colors.transparent,
            unselectedLabelColor: AppColors.inactiveIconColor,
            unselectedLabelStyle:
                AppTextStyle.textStyle16Bold.copyWith(fontSize: 15.7),
            indicatorColor: AppColors.secondaryColor,
            tabs: [
              Tab(text: 'Your Events'),
              Tab(text: 'Calendar'),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: AppSizes.defaultScreenPadding,
                left: AppSizes.defaultScreenPadding,
                top: AppSizes.defaultScreenPadding,
              ),
              child: TabBarView(
                children: [
                  YourEventsTabBarView(),
                  CalendarTabBarView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
