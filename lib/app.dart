import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_event_planner/config/routing/app_router.dart';
import 'package:smart_event_planner/features/authentication/login_screen.dart';
import 'package:smart_event_planner/features/splash/screens/splash_screen.dart';
import 'package:smart_event_planner/features/onboarding/onboarding_screens.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Event Planner',
      locale: const Locale('en'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      initialRoute: Routes.splashScreen,
      routes: {
        Routes.splashScreen: (context) => const SplashScreen(),
        Routes.onboardingScreen: (context) => const OnboardingScreens(),
        Routes.loginScreen: (context) => const LoginScreen(),
      },
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
