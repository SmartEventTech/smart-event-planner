import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/auth/presentation/widgets/scocial_button.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TSocialButton(
          onPressed: () {},
          socialIcon: AppImages.google,
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        const TSocialButton(socialIcon: AppImages.facebook),
      ],
    );
  }

  // _navigateToMenuPage(BuildContext context) {
  //   context.removeAll(const NavigationMenu());
  // }
}
