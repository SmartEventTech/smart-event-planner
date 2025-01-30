import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen_body.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/chat_bot_floating_button.dart';
import 'package:smart_event_planner/shared/widgets/appBar/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: HomeScreenBody(),
      floatingActionButton: ChatBotFloatingActionButton(),
    );
  }
}
