import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/localization_extension.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.tr.eventsYouMightLike,
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
