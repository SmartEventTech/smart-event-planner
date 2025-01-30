import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class InterestedCard extends StatelessWidget {
  const InterestedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(AppSizes.defaultPadding),
            width: 65,
            height: 65,
            decoration: ShapeDecoration(
              gradient: AppColors.interestedCardColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.interestedCardRadius),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(AppImages.programmingIcon),
            ),
          ),
        ),
        const SizedBox(height: 3),
        FittedBox(
          child: Text(
            'IT',
            style: AppTextStyle.textStyle12Regular
                .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
