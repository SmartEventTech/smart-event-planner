import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading(
      {super.key, required this.title, required this.btnTitle, this.onPressed});
  final String title;
  final String btnTitle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyle.textStyle18Medium),
        TextButton(
          onPressed: onPressed,
          child: Text(
            btnTitle,
            style: AppTextStyle.textStyle16Medium
                .copyWith(color: AppColors.textBtnColor),
          ),
        ),
      ],
    );
  }
}
