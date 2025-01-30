import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:smart_event_planner/api_edpoints.dart';
import 'package:smart_event_planner/app.dart';
import 'package:device_preview/device_preview.dart';

void main() {
    Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}
