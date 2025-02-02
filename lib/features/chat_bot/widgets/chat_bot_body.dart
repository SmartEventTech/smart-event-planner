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
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "User",
    profileImage: AppImages.userAvatar,
  );
  ChatUser botUser = ChatUser(
    id: "1",
    firstName: "Eventy",
    profileImage: AppImages.chatbotAvatar,
  );

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildUI(),
        if (messages.isEmpty && !_isLoading) _buildNoChatsWidget(),
      ],
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: _inputStyle(),
      messageOptions: MessageOptions(
        currentUserContainerColor: const Color(0xff0E377C),
        containerColor: const Color(0xffD9D9D9),
      ),
      typingUsers: _isLoading ? [botUser] : [],
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  Widget _buildNoChatsWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: SvgPicture.asset(AppImages.startChatbotMessage),
      ),
    );
  }

  InputOptions _inputStyle() {
    return InputOptions(
      sendOnEnter: true,
      alwaysShowSend: true,
      cursorStyle: const CursorStyle(
        color: Colors.deepPurple,
      ),
      inputDecoration: InputDecoration(
        hintText: "Write a message...",
        hintStyle: AppTextStyle.textStyle16Medium(context).copyWith(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.3),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: AppSizes.slg,
          horizontal: AppSizes.slg + 4,
        ),
      ),
      inputTextStyle: AppTextStyle.textStyle16Medium(context),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
      _isLoading = true;
    });

    try {
      String question = chatMessage.text;

      gemini.streamGenerateContent(question).listen(
        (event) {
          String response = event.content?.parts
                  ?.whereType<TextPart>()
                  .map((part) => part.text)
                  .join(" ") ??
              "No response";
          // How I Can Learn Flutter

          if (mounted) {
            setState(() {
              if (messages.isNotEmpty && messages.first.user == botUser) {
                messages.first = ChatMessage(
                  text: response,
                  user: botUser,
                  createdAt: messages.first.createdAt,
                );
              } else {
                messages.insert(
                  0,
                  ChatMessage(
                    text: response,
                    user: botUser,
                    createdAt: DateTime.now(),
                  ),
                );
              }
            });
          }
        },
        onError: (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Error communicating with Gemini API')),
            );
          }
          print("Gemini API Error: $error");
          setState(() {
            _isLoading = false;
          });
        },
        onDone: () {
          print("Gemini stream completed");
          setState(() {
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
      print("General Error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
