import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: GridView.builder(
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(AppSizes.defaultPadding),
                  width: 60,
                  height: 60,
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
        },
      ),
    );
  }
}
