import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/sections/section_heading.dart';

class HomeSliverBarBottomTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeSliverBarBottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: false,
      indicatorColor: AppColors.blueTextColor,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      tabs: [
        Container(
          color: Colors.white,
          padding:
              EdgeInsets.symmetric(horizontal: AppSizes.defaultScreenPadding),
          child: Tab(
            child: SectionHeading(
              title: 'Events you might like',
              btnTitle: 'View All',
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
