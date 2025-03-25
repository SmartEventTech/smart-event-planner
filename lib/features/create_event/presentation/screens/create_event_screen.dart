import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
import 'package:smart_event_planner/shared/widgets/appBar/user_avatar_widget.dart';

import 'package:smart_event_planner/shared/widgets/buttons/custom_eleveted_btn.dart';

class CreateEvent extends StatelessWidget {
  const CreateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
          SliverAppBar(
            pinned: true,
            // expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('AppBar'),
              background: Container(color: Colors.blue),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Item $index'),
              ),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
