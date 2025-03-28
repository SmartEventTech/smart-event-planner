import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/cubits/signin_cubit/signin_cubit.dart';
import 'package:smart_event_planner/core/cubits/signup_cubit/signup_cubit.dart';
import 'package:smart_event_planner/core/repos/auth_repo/auth_repo.dart';
import 'package:smart_event_planner/features/authentication/otp_werificatioin_screen.dart';
import 'package:smart_event_planner/features/hobbiesScreen/hobby_screen.dart';
import 'package:smart_event_planner/features/authentication/login_screen.dart';
import 'package:smart_event_planner/features/authentication/signup_screen.dart';
import 'package:smart_event_planner/features/splash/screens/splash_screen.dart';
import 'package:smart_event_planner/features/onboarding/onboarding_screens.dart';
import 'package:smart_event_planner/shared/widgets/events/create_event_screen.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen.dart';
import 'package:smart_event_planner/features/search/presentation/screens/search_secreen.dart';
import 'package:smart_event_planner/features/sceduale/presentation/screens/schedule_screen.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreens());
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignInCubit(
                    authRepo: context.read<AuthRepo>(),
                  ),
                  child: const LoginScreen(),
                ));
      case Routes.signupScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignupCubit(
                    authRepo: context.read<AuthRepo>(),
                  ),
                  child: const SignupScreen(),
                ));

        
      case Routes.hobbyScreen:
        return MaterialPageRoute(builder: (_) => const HobbyScreen());
      case Routes.navigationScreen:
        return MaterialPageRoute(builder: (_) => NavigationScreen());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => Placeholder());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => SearchSecreen());
      case Routes.scheduleScreen:
        return MaterialPageRoute(builder: (_) => ScheduleScreen());
      case Routes.createEventScreen:
        return MaterialPageRoute(builder: (_) => CreateEventScreen());
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
