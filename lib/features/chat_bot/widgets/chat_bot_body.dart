// ignore_for_file: deprecated_member_use, avoid_print

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  );
  ChatUser botUser = ChatUser(
    id: "1",
    firstName: "Eventy",
    profileImage: "assets/images/chat_bot_icons/ChatBotIcon.png",
  );

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildUI(),
         // Center the indicator
        if (messages.isEmpty && !_isLoading) // Show custom widget if no messages and not loading
          _buildNoChatsWidget(),
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
      
    // Important: Remove default placeholder
    );
  }


  Widget _buildNoChatsWidget() {
    return Center( // Center the widget
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: SvgPicture.asset(
              "assets/images/chat_bot_icons/HI, how can I help you today.svg", // Replace with your image path
              
            ),
          ),
          SizedBox(height: 160),
        
        ],
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