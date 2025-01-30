import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';

class ChatBotFloatingActionButton extends StatelessWidget {
  const ChatBotFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.interestedCardColor,
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {},
        shape: CircleBorder(),
        child: Center(child: SvgPicture.asset(AppImages.chatBotIcon)),
      ),
    );
  }
}
