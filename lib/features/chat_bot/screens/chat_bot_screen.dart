import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: SvgPicture.asset(
                isDark ? AppImages.eventLogo2 : AppImages.eventLogo,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: SvgPicture.asset(
                isDark ? AppImages.chatBotIcon : AppImages.chatBotIcon2,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
          vertical: AppSizes.md,
        ),
        child: Column(
          children: [
            Divider(height: 1, color: AppColors.dividerColor),
            Expanded(child: const ChatBotBody()),
          ],
        ),
      ),
    );
  }
}
