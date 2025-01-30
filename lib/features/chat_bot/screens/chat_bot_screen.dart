import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/features/chat_bot/widgets/chat_bot_body.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
            )),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset('assets/images/chat_bot_icons/EventyText.svg'),
            SvgPicture.asset('assets/images/chat_bot_icons/chat-bot.svg'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(height: 3, color: Color(0xffD9D9D9)),
          ),
          Expanded(child: const ChatBotBody()),
        ],
      ),
    );
  }
}
