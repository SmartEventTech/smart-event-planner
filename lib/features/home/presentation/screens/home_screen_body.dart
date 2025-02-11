import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/netsted_scroll_view/home_sliverbar_bottom_tabbar.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/netsted_scroll_view/sliver_appbar_body.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/suggested_section/suggested_events_section.dart';

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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SliverAppBarBody(),
            ),
            SliverAppBar(
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              expandedHeight: 0,
              elevation: 0,
              

              backgroundColor: isDark
                  ? AppColors.lightSliverAppBarColor
                  : AppColors.darkSliverAppBarColor,
              bottom: HomeSliverBarBottomTabBar(),
            ),
            SliverToBoxAdapter(
              child: const SizedBox(height: AppSizes.spaceBtwItem),
            ),
            SuggestedEventsSection(),
            SliverToBoxAdapter(
              child: const SizedBox(height: AppSizes.spaceBtwItem),
            ),
          ],
        ),
      ),
    );
  }
}
