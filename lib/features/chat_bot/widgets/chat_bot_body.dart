// ignore_for_file: deprecated_member_use, avoid_print

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class ChatBotBody extends StatefulWidget {
  const ChatBotBody({super.key});

  @override
  State<ChatBotBody> createState() => _ChatBotBodyState();
}

class _ChatBotBodyState extends State<ChatBotBody> {
  final Gemini gemini = Gemini.instance;
  final List<ChatMessage> messages = [];
  final ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "User",
    profileImage: AppImages.userAvatar,
  );
  final ChatUser botUser = ChatUser(
    id: "1",
    firstName: "Eventy",
    profileImage: AppImages.chatbotAvatar,
  );

  bool _isLoading = false;
  String _fullResponse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildChatInterface(),
          if (messages.isEmpty && !_isLoading) _buildWelcomeWidget(),
        ],
      ),
    );
  }

  Widget _buildChatInterface() {
     return DashChat(
    inputOptions: _inputStyle(),
    messageOptions: MessageOptions(
      currentUserContainerColor: AppColors.primaryColor,
      containerColor: AppColors.fillColor,
      currentUserTextColor: Colors.white,  // White text for user bubbles
      textColor: Colors.black,             // Black text for bot bubbles
      maxWidth: MediaQuery.of(context).size.width * 0.75,
      messageTextBuilder: (message, _, __) {
        return SelectableText(
          message.text,
          style: TextStyle(
            fontSize: 16,                  // Larger font size
            color: message.user == currentUser 
                ? Colors.white            // User message text color
                : Colors.black,            // Bot message text color
            fontWeight: FontWeight.w300,    // Medium weight
          ),
        );
      },
    ),
    typingUsers: _isLoading ? [botUser] : [],
    currentUser: currentUser,
    onSend: _handleMessageSending,
    messages: messages,
  );
}
  Widget _buildWelcomeWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.startChatbotMessage,
              height: 200,
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  InputOptions _inputStyle() {
    return InputOptions(
      sendOnEnter: true,
      alwaysShowSend: true,
      cursorStyle: CursorStyle(color: AppColors.primaryColor),
      inputDecoration: InputDecoration(
        hintText: "Write a message...",
        hintStyle: AppTextStyle.textStyle16Medium(context).copyWith(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.secondaryColor, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: AppSizes.slg,
          horizontal: AppSizes.slg + 4,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      inputTextStyle: AppTextStyle.textStyle16Medium(context).copyWith(
        fontSize: 14      ),
      sendButtonBuilder: (onSend) {
        return IconButton(
          icon: Icon(Icons.send, color: AppColors.primaryColor),
          onPressed: onSend,
        );
      },
    );
  }

  void _handleMessageSending(ChatMessage chatMessage) {
    setState(() {
      messages.insert(0, chatMessage);
      _isLoading = true;
      _fullResponse = '';
    });

    // Create initial empty bot message
    final botMessage = ChatMessage(
      text: '...',
      user: botUser,
      createdAt: DateTime.now(),
    );
    setState(() => messages.insert(0, botMessage));

    try {
      gemini.streamGenerateContent(chatMessage.text).listen(
        (event) {
          final chunk = event.content?.parts
                  ?.whereType<TextPart>()
                  .map((part) => part.text)
                  .join(" ") ?? '';
          
          _fullResponse += chunk;

          if (mounted) {
            setState(() {
              messages[0] = ChatMessage(
                text: _fullResponse,
                user: botUser,
                createdAt: messages[0].createdAt,
              );
            });
          }
        },
        onError: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${error.toString()}')),
            );
            setState(() {
              _isLoading = false;
              messages[0] = ChatMessage(
                text: "Sorry, I couldn't process your request.",
                user: botUser,
                createdAt: messages[0].createdAt,
              );
            });
          }
        },
        onDone: () {
          if (mounted) {
            setState(() => _isLoading = false);
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
        setState(() {
          _isLoading = false;
          messages[0] = ChatMessage(
            text: "An error occurred. Please try again.",
            user: botUser,
            createdAt: messages[0].createdAt,
          );
        });
      }
    }
  }
}
