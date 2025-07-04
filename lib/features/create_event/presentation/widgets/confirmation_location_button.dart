import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';

class ConfirmationLocationButton extends StatelessWidget {
  const ConfirmationLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.pushNamedPage(Routes.mapScreen),
        style: ElevatedButton.styleFrom(
          
          backgroundColor: isDark
              ? const Color.fromARGB(255, 56, 55, 55)
              : AppColors.confirmLocationColor,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            
            borderRadius: BorderRadius.circular(24),
          ),
          side:  BorderSide(
            color: AppColors.secondaryColor,
          ),
          elevation: 2,
          shadowColor: isDark ? Colors.black26 : Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppImages.locationPin,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                isDark ? Colors.white : AppColors.black,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Tap to choose a location',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white : AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
