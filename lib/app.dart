import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

import 'package:smart_event_planner/core/theme/app_theme.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/config/routing/app_router.dart';
import 'package:smart_event_planner/core/utils/helpers/app_context.dart';
import 'package:smart_event_planner/core/services/api_service.dart';
import 'package:smart_event_planner/core/repos/auth_repo/auth_repo.dart';
import 'package:smart_event_planner/core/repos/auth_repo/auth_repo_impl.dart';


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
        Provider<ApiService>(
          create: (context) => ApiService(
            dio: context.read<Dio>(),
            connectivity: context.read<Connectivity>(),
          ),
        ),
        Provider<AuthRepo>(
          create: (context) => AuthRepoImplementation(
            apiService: context.read<ApiService>(),
            logger: context.read<Logger>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: AppContext.navigatorKey,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        title: 'Smart Event Planner',
        locale: const Locale('en'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}