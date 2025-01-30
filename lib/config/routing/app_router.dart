import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/screens/navigation_screen.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen.dart';
import 'package:smart_event_planner/features/onboarding/screens/onboarding_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navigationScreen:
        return MaterialPageRoute(builder: (_) => NavigationScreen());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => Placeholder());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => Placeholder());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
