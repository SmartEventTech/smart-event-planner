import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
import 'package:smart_event_planner/features/profile/presentation/widgets/profile_tab_bar.dart';

import 'package:smart_event_planner/shared/widgets/buttons/custom_eleveted_btn.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';
import 'package:smart_event_planner/shared/widgets/appBar/user_avatar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: _buildAppBar(isDark, context),
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserAvatarWidget(
                    maxRadius: 60,
                    minRadius: 30,
                    showBorder: false,
                    userImageUrl: AppImages.userAvatar,
                  ),
                  const SizedBox(height: AppSizes.slg),
                  Column(
                    children: [
                      Text(
                        'John Doe',
                        style: AppTextStyle.textStyle24Medium(context),
                      ),
                      Text(
                        'BwM4V@example.com',
                        style: AppTextStyle.textStyle16Regular(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItem * 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultScreenPadding,
                    ),
                    child: Row(
                      children: [
                        CustomElevetedBtn(
                          title: 'Share Profile',
                          icon: Icons.share,
                        ),
                        const SizedBox(width: 30),
                        CustomElevetedBtn(
                          title: 'Edit Profile',
                          icon: Iconsax.edit,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBtwSection),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(height: 3, color: const Color.fromARGB(255, 195, 191, 191)),
                  ),
                  SizedBox(height: AppSizes.md),
                  ProfileTabBar(),
                  SizedBox(height: AppSizes.spaceBtwSection),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: AppSizes.defaultScreenPadding,
                      left: AppSizes.defaultScreenPadding,
                    ),
                    child: EventsListView(
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: AppSizes.defaultScreenPadding,
                      left: AppSizes.defaultScreenPadding,
                    ),
                    child: EventsListView(
                      editCard: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDark, BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: isDark ? Colors.black : AppColors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text('My Profile', style: AppTextStyle.textStyle20Medium(context)),
    );
  }
}
