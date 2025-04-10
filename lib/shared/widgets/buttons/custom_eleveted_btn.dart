import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class CustomElevetedBtn extends StatelessWidget {
  const CustomElevetedBtn(
      {super.key,
      required this.title,
      this.icon,
      this.color,
      this.textColor,
      this.onPressed});
  final String title;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: TextButton(
        
        
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            side:  BorderSide(
          width: 1,
          color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    size: 22,
                    color: AppColors.primaryColor,
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: AppSizes.slg),
            Flexible(
              child: FittedBox(
                child: Text(title,
                    style: AppTextStyle.textStyle17Medium(context).copyWith(
                      color: textColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
