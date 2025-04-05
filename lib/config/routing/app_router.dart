import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/forget_password/reset_password_cubit.dart';
import 'package:smart_event_planner/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:smart_event_planner/features/auth/presentation/screens/otp_screen.dart';
import 'package:smart_event_planner/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:smart_event_planner/features/chat_bot/screens/chat_bot_screen.dart';
import 'package:smart_event_planner/features/hobbiesScreen/hobby_screen.dart';
import 'package:smart_event_planner/features/auth/presentation/screens/login_screen.dart';
import 'package:smart_event_planner/features/auth/presentation/screens/signup_screen.dart';
import 'package:smart_event_planner/features/onboarding/screens/onboarding_screens.dart';
import 'package:smart_event_planner/features/profile/presentation/screens/profile_screen.dart';
import 'package:smart_event_planner/shared/widgets/events/create_event_screen.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen.dart';
import 'package:smart_event_planner/features/search/presentation/screens/search_secreen.dart';
import 'package:smart_event_planner/features/sceduale/presentation/screens/schedule_screen.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class AppRouter {
  static final Map<String, Widget Function(BuildContext)> _routes = {
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
    Routes.otpVerificationScreen: (_) => OtpScreen(),
    Routes.profileScreen: (_) => ProfileScreen(),
    Routes.resetPasswordScreen: (_) => BlocProvider(
          create: (context) => ResetPasswordCubit(),
          child: ResetPasswordScreen(),
        ),
    Routes.forgetPasswordScreen: (_) => BlocProvider(
          create: (context) => ResetPasswordCubit(),
          child: ForgetPasswordScreen(),
        ),
  };

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final pageBuilder = _routes[settings.name];

    if (pageBuilder != null) {
      return MaterialPageRoute(builder: pageBuilder, settings: settings);
    }

    return null;
  }
}
