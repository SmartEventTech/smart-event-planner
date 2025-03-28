import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class ProfileTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppSizes.defaultScreenPadding),
      child: TabBar(
        tabAlignment: TabAlignment.fill,
        labelStyle: AppTextStyle.textStyle16Bold(context),
        dividerColor: Colors.transparent,
        unselectedLabelColor: AppColors.inactiveIconColor,
        unselectedLabelStyle:
            AppTextStyle.textStyle16Bold(context).copyWith(fontSize: 15.7),
        indicatorColor: AppColors.secondaryColor,
        tabs: [
          Tab(
            child: FittedBox(
              child: Text('Favourites'),
            ),
          ),
          Tab(
            child: FittedBox(
              child: Text('Customized events'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
