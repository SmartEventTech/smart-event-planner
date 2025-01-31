import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/sceduale/presentation/screens/schedule_screen_body.dart';
import 'package:smart_event_planner/shared/widgets/appBar/custom_appbar.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ScheduleScreenBody(),
    );
  }
}
