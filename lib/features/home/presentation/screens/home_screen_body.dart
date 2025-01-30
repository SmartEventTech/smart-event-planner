import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/home_sliverbar_bottom_tabBar.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/nested_scroll_view_body.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/sliver_appbar_body.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.defaultBorderRadius),
          topRight: Radius.circular(AppSizes.defaultBorderRadius),
        ),
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.sizeOf(context).height * 0.62,
              backgroundColor: AppColors.sliverAppBarColor,
              flexibleSpace: SliverAppBarBody(),
              bottom: HomeSliverBarBottomTabBar(),
            ),
          ],
          body: NestedScrollViewBody(),
        ),
      ),
    );
  }
}
