import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/core/utils/helpers/share/share_helper.dart';
import 'package:smart_event_planner/core/widgets/shimmer/shimmer_widget.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_cubit.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_event/user_event_cubit.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_state.dart';
import 'package:smart_event_planner/features/profile/presentation/widgets/build_customized_event_list.dart';
import 'package:smart_event_planner/features/profile/presentation/widgets/profile_tab_bar.dart';

import 'package:smart_event_planner/shared/widgets/buttons/custom_eleveted_btn.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';
import 'package:smart_event_planner/shared/widgets/appBar/user_avatar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => getIt.get<UserEventCubit>()..fetchCustomizedEvents(),
      child: Scaffold(
        appBar: _buildAppBar(isDark, context),
        body: DefaultTabController(
          length: 2,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const UserAvatarWidget(
                      maxRadius: 60,
                      minRadius: 30,
                      showBorder: false,
                      userImageUrl: AppImages.userAvatar,
                    ),
                    const SizedBox(height: AppSizes.slg),
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadedState) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.defaultScreenPadding),
                            child: Column(
                              children: [
                                Text(
                                  state.userModel.name.isNotEmpty
                                      ? state.userModel.name
                                      : 'No Name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTextStyle.textStyle24Medium(context),
                                ),
                                Text(
                                  state.userModel.email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTextStyle.textStyle16Regular(context),
                                ),
                              ],
                            ),
                          );
                        }
                        return _builoadingWidget(context);
                      },
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems * 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.defaultScreenPadding,
                      ),
                      child: Row(
                        children: [
                          CustomElevetedBtn(
                            title: 'Share Profile',
                            icon: Icons.share,
                            onPressed: () {
                              final link = context.read<UserCubit>().profelink;
                              ShareHelper.shareContent(link);
                            },
                          ),
                          const SizedBox(width: 30),
                          CustomElevetedBtn(
                            title: 'Edit Profile',
                            icon: Iconsax.edit,
                            onPressed: () async {
                              try {
                                await getIt.get<AuthRepo>().logout();
                                if (context.mounted) {
                                  context.pushNamedAndRemoveUntilPage(
                                    Routes.loginScreen,
                                  );
                                }
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(
                          height: 3,
                          color: Color.fromARGB(255, 195, 191, 191)),
                    ),
                    const SizedBox(height: AppSizes.md),
                    const ProfileTabBar(),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                  ],
                ),
              ),
              const SliverFillRemaining(
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
                      child: BuildCustomizedEventList(),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.spaceBtwItems),
              ),
            ],
          ),
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

  _builoadingWidget(BuildContext context) => Column(
        children: [
          ShimmerWidget(
              width: MediaQuery.of(context).size.width * 0.5, height: 16),
          const SizedBox(height: 8),
          ShimmerWidget(
              width: MediaQuery.of(context).size.width * 0.5, height: 16),
          const SizedBox(height: 3),
        ],
      );
}
