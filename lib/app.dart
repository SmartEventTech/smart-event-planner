import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/Singelton/shared_pref_singelton.dart';
import 'package:smart_event_planner/core/constants/app_constants.dart';
import 'package:smart_event_planner/core/storage/secure_storage.dart';
import 'package:smart_event_planner/core/theme/app_theme.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/config/routing/app_router.dart';
import 'package:smart_event_planner/core/utils/helpers/app_context.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_cubit.dart';

String route = Routes.onboardingScreen;

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Logger>(create: (_) => Logger()),
        Provider<Connectivity>(create: (_) => Connectivity()),
        Provider<Dio>(create: (_) => Dio()),
      ],
      child: BlocProvider(
        create: (context) => getIt.get<UserCubit>()
          ..getProfile()
          ..shareProfile(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppContext.navigatorKey,
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          title: 'Smart Event Planner',
          locale: const Locale('en'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          onGenerateRoute: (settings) => appRouter.generateRoute(settings),
          initialRoute: route,
        ),
      ),
    );
  }
}

Future<void> entry() async {
  SecureStorage secureStorage = SecureStorage();

  bool isOnBoardingSeen = SharedPreferenceSingleton.getBool(kisOnBoardingSeen);

  if (isOnBoardingSeen && await secureStorage.getAccessToken() == null) {
    route = Routes.loginScreen;
  } else if (await secureStorage.getAccessToken() != null) {
    route = Routes.navigationScreen;
  } else {
    route = Routes.onboardingScreen;
  }
}
