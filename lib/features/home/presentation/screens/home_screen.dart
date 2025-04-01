import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_event_planner/core/storage/secure_storage.dart';
import 'package:smart_event_planner/shared/widgets/appBar/custom_appbar.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen_body.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/chat_bot_floating_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Home Screen + ${SecureStorage().getAccessToken().then((print))}");
    return Scaffold(
      appBar: CustomAppBar(),
      body: HomeScreenBody(),
      floatingActionButton: ChatBotFloatingActionButton(),
    );
  }
}
