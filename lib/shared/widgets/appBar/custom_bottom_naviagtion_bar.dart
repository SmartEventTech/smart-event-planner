import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.btnNavBarRadius),
            topRight: Radius.circular(AppSizes.btnNavBarRadius),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.search_normal), label: "Search"),
              BottomNavigationBarItem(icon: SizedBox(), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.calendar), label: "Schedule"),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.user), label: "Profile"),
            ],
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration:
                ShapeDecoration(color: Colors.white, shape: CircleBorder()),
            child: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.interestedCardColor,
              ),
              child: Center(
                child: SvgPicture.asset(AppImages.plusIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
