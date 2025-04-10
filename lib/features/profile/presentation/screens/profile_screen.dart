import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
import 'package:smart_event_planner/core/theme/theme_provider.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/core/utils/helpers/share/share_helper.dart';
import 'package:smart_event_planner/core/widgets/shimmer/shimmer_widget.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_cubit.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_event/user_event_cubit.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_state.dart';
import 'package:smart_event_planner/features/profile/presentation/widgets/profile_list_tile.dart';
import 'package:smart_event_planner/features/profile/presentation/widgets/profile_switch_tile.dart';
import 'package:smart_event_planner/shared/widgets/buttons/custom_eleveted_btn.dart';
import 'package:smart_event_planner/shared/widgets/appBar/user_avatar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final isdark = Theme.of(context).brightness == Brightness.dark;
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: isdark ? AppColors.mainblackColor : AppColors.white,
            icon: const Icon(
              Iconsax.logout,
              size: 40,
              color: Colors.red,
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: AppTextStyle.textStyle16Regular(context),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) return;

    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );

    try {
      await getIt.get<AuthRepo>().logout();

      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        context.pushNamedAndRemoveUntilPage(Routes.loginScreen);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: ${e.toString()}')),
        );
      }
      debugPrint('Logout error: $e');
    }
  }
    ///
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => getIt.get<UserEventCubit>()..fetchCustomizedEvents(),
      child: Scaffold(
        appBar: _buildAppBar(isDark, context),
        body: CustomScrollView(
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
                                style: AppTextStyle.textStyle24Medium(context),
                              ),
                              Text(
                                state.userModel.email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.textStyle16Regular(context),
                              ),
                            ],
                          ),
                        );
                      }
                      return _builoadingWidget(context);
                    },
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultScreenPadding,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomElevetedBtn(
                            title: 'Edit Profile',
                            icon: Iconsax.edit,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Column(
                    children: [
                      ProfileListTile(
                        title: 'Share Profile',
                        leadingIcon: Iconsax.share,
                        onTap: () {
                          final link = context.read<UserCubit>().profelink;
                          ShareHelper.shareContent(link);
                        },
                      ),
                      ProfileListTile(
                        title: 'Favourite Events',
                        leadingIcon: Iconsax.star,
                        onTap: () {},
                      ),
                      ProfileListTile(
                        title: 'Events You Created',
                        leadingIcon: Iconsax.calendar_add,
                        onTap: () {},
                      ),
                      ProfileSwitchTile(
                        title: 'Dark Mode',
                        value: themeProvider.themeMode == ThemeMode.dark,
                        activeColor: Colors.white,
                        icon: Iconsax.moon,
                        onChanged: (value) async {
                          final newMode =
                              value ? ThemeMode.dark : ThemeMode.light;
                          await themeProvider.setTheme(newMode);
                        },
                      ),
                      ProfileListTile(
                        title: 'Logout',
                        hideTrailing: true,
                        iconColor: Colors.red,
                        leadingIcon: Iconsax.logout,

                        onTap: () => _handleLogout(context),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDark, BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: isDark ? AppColors.mainblackColor : AppColors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text('My Profile', style: AppTextStyle.textStyle20Medium(context)),
    );
  }

  Widget _builoadingWidget(BuildContext context) => Column(
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