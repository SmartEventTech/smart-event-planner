import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
<<<<<<< HEAD

import 'package:smart_event_planner/features/map/presentation/screens/map_screen.dart';
=======
>>>>>>> ebd962399bcb263059472c1e1b24807e2878bdc8

class BottomNavBarPlusIcon extends StatelessWidget {
  const BottomNavBarPlusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      top: -25,
      left: 0,
      right: 0,
<<<<<<< HEAD
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: ShapeDecoration(color: Colors.white, shape: CircleBorder()),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen()));
            // context.push(
            //   // Scaffold(
            //   //   appBar: AppBar(),
            //   //   body: Center(child: Text('Add Event Screen')),
            //   // ),
              
            // );
          },
=======
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: isDark ? AppColors.darkScaffoldBgColor : AppColors.white,
            shape: CircleBorder(),
          ),
>>>>>>> ebd962399bcb263059472c1e1b24807e2878bdc8
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
    );
  }
}
