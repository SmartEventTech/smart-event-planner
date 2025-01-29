import 'package:flutter/material.dart';
import 'package:smart_event_planner/app.dart';
import 'package:smart_event_planner/config/routing/app_router.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(
      appRouter: AppRouter(),
    ),
  ));
}
