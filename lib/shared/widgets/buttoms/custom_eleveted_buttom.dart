import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

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
