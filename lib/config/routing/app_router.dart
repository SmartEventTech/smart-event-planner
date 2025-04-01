import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/features/auth/presentation/otp_werificatioin_screen.dart';
import 'package:smart_event_planner/features/chat_bot/screens/chat_bot_screen.dart';
import 'package:smart_event_planner/features/hobbiesScreen/hobby_screen.dart';
import 'package:smart_event_planner/features/auth/presentation/screens/login_screen.dart';
import 'package:smart_event_planner/features/auth/presentation/screens/signup_screen.dart';
import 'package:smart_event_planner/features/splash/screens/splash_screen.dart';
import 'package:smart_event_planner/features/onboarding/onboarding_screens.dart';
import 'package:smart_event_planner/shared/widgets/events/create_event_screen.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen.dart';
import 'package:smart_event_planner/features/search/presentation/screens/search_secreen.dart';
import 'package:smart_event_planner/features/sceduale/presentation/screens/schedule_screen.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class AppRouter {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    Routes.splashScreen: (_) => const SplashScreen(),
    Routes.onboardingScreen: (_) => const OnboardingScreens(),
    Routes.loginScreen: (_) => const LoginScreen(),
    Routes.signupScreen: (_) => const SignupScreen(),
    Routes.hobbyScreen: (_) => const HobbyScreen(),
    Routes.navigationScreen: (_) => NavigationScreen(),
    Routes.registerScreen: (_) => const Placeholder(),
    Routes.homeScreen: (_) => HomeScreen(),
    Routes.searchScreen: (_) => SearchSecreen(),
    Routes.scheduleScreen: (_) => ScheduleScreen(),
    Routes.createEventScreen: (_) => CreateEventScreen(),
    Routes.chatBotScreen: (_) => ChatBotScreen(),
    Routes.otpVerificationScreen: (_) => OtpVerificationScreen(),
  };

   Route<dynamic>? generateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name ?? '');
    final path =
        (uri.pathSegments.isNotEmpty) ? '/${uri.pathSegments[0]}' : uri.path;

    final pageBuilder = _routes[path];

    if (pageBuilder != null) {
      return MaterialPageRoute(builder: pageBuilder, settings: settings);
    }

    return null;
  }
}
