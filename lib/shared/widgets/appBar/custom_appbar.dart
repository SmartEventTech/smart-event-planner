import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/appBar/user_avatar_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultScreenPadding,
      ),
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        title: Image.asset(
          AppImages.appLogo,
          width: 90,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.message),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.notification),
          ),
          SizedBox(width: 4),
          UserAvatarWidget(userImageUrl: AppImages.userAvatar)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
