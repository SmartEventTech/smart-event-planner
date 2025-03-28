import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/features/hobbiesScreen/hobby_screen.dart';
import 'package:smart_event_planner/features/authentication/login_screen.dart';
import 'package:smart_event_planner/features/authentication/signup_screen.dart';
import 'package:smart_event_planner/features/splash/screens/splash_screen.dart';
import 'package:smart_event_planner/features/onboarding/onboarding_screens.dart';
import 'package:smart_event_planner/features/onboarding/screens/onboarding_screen.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen.dart';
import 'package:smart_event_planner/features/sceduale/presentation/screens/schedule_screen.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreens());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.hobbyScreen:
        return MaterialPageRoute(builder: (_) => const HobbyScreen());
      case Routes.navigationScreen:
        return MaterialPageRoute(builder: (_) => NavigationScreen());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => Placeholder());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.scheduleScreen:
        return MaterialPageRoute(builder: (_) => ScheduleScreen());
      default:
        return null;
    }
  }
}
