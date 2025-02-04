import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';
import 'package:smart_event_planner/shared/widgets/appBar/user_avatar_widget.dart';
import 'package:smart_event_planner/features/profile/presentation/widgets/profile_sliver_bottom_tab_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: isDark ? Colors.black : AppColors.lightScaffoldBgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:
            Text('My Profile', style: AppTextStyle.textStyle20Medium(context)),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  automaticallyImplyLeading: false,
                  expandedHeight:
                      MediaQuery.sizeOf(context).height * 0.45, //398
                  backgroundColor:
                      isDark ? Colors.black : AppColors.lightScaffoldBgColor,
                  flexibleSpace: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                  title: 'Shared Profile',
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
                          SizedBox(height: 20),
                          Divider(height: 3, color: AppColors.dividerColor),
                        ],
                      ),
                    ),
                  ),
                  bottom: ProfileSliverBottomTabBar(),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(
                top: AppSizes.spaceBtwSection,
              ),
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: AppSizes.defaultScreenPadding,
                      left: AppSizes.defaultScreenPadding,
                    ),
                    child: EventsListView(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: AppSizes.defaultScreenPadding,
                      left: AppSizes.defaultScreenPadding,
                    ),
                    child: EventsListView(editCard: true),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class CustomElevetedBtn extends StatelessWidget {
  const CustomElevetedBtn({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.outlinedBtnBorderColor,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 27,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: AppSizes.slg),
            Flexible(
              child: FittedBox(
                child:
                    Text(title, style: AppTextStyle.textStyle17Medium(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
