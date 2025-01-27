import 'screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/screens/onboarding_screens.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreens.id: (context) => const OnboardingScreens(),
      },
    );
  }
}