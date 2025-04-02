import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/Singelton/shared_pref_singelton.dart';
import 'package:smart_event_planner/core/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isOnBoardingSeen = SharedPreferenceSingleton.getBool(kisOnBoardingSeen);
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      if (isOnBoardingSeen) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.loginScreen);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, Routes.onboardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logos/appLogo.png'),
      ),
    );
  }
}
