import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/features/chat_bot/screens/chat_bot_screen.dart';

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
        onPressed: () {
          context.push(const ChatBotScreen());
        },
        shape: CircleBorder(),
        child: Center(child: SvgPicture.asset(AppImages.chatBotIcon)),
      ),
    );
  }
}
