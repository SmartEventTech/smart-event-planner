import 'package:flutter/material.dart';
import 'package:smart_event_planner/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:smart_event_planner/api_edpoints.dart';
import 'package:smart_event_planner/config/routing/app_router.dart';
import 'package:smart_event_planner/core/Singelton/shared_pref_singelton.dart';
import 'package:smart_event_planner/core/utils/helpers/app_context.dart';

void main() async{
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceSingleton.init();
  
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        AppContext.navigatorKey;
        return MyApp(
          appRouter: AppRouter(),
        );
      },
    ),
  );
}
