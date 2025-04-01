import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:smart_event_planner/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:smart_event_planner/api_edpoints.dart';
import 'package:smart_event_planner/config/routing/app_router.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/Singelton/shared_pref_singelton.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_event_planner/core/storage/app_storage.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);

  // Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Splash Screen
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // Shared Preferences Initialization
  await SharedPreferenceSingleton.init();
  await AppStorage.init();

  // Dotenv Initialization
  await dotenv.load(fileName: '.env');

  // Service Locator Initialization
  await initializeDependencies();

  // Remove Splash Screen after initialization
  FlutterNativeSplash.remove();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return MyApp(
          appRouter: AppRouter(),
        );
      },
    ),
  );
}
