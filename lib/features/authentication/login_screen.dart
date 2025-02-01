import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/widgets/login_widget.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildLoginBackground(),
          buildLoginForm(context),
        ],
      ),
    );
  }
}
