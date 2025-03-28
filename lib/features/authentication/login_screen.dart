import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/authentication/widgets/login_form.dart';
import 'package:smart_event_planner/shared/widgets/auth/auth_header.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header // Image
            AuthHeader(),
            // Login Form
            // LoginForm()
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: LoginForm(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

