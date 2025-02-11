import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';

import 'package:smart_event_planner/features/map/presentation/screens/map_screen.dart';

class BottomNavBarPlusIcon extends StatelessWidget {
  const BottomNavBarPlusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20,
      left: 0,
      right: 0,
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
