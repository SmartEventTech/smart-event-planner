import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/netsted_scroll_view/home_sliverbar_bottom_tabbar.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/netsted_scroll_view/nested_scroll_view_body.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/netsted_scroll_view/sliver_appbar_body.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
              expandedHeight:
                  490, //MediaQuery.sizeOf(context).height * 0.562, // 0.62
              backgroundColor:
                  isDark ? Colors.black : AppColors.sliverAppBarColor,
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
