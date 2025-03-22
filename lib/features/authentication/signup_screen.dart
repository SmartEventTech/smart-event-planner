import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/widgets/signup_widget.dart';

class SignupScreen extends StatelessWidget {
  static const String id = 'SignupScreen';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildSignupBackground(),
          buildSignupForm(context),
        ],
      ),
    );
  }
}
