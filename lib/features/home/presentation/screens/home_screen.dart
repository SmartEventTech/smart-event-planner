import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/shared/widgets/appBar/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
          vertical: AppSizes.sm,
        ),
        child: Column(
          children: [
            CustomAppBar(),
            const SizedBox(height: AppSizes.spaceBtwItem),
          ],
        ),
      ),
    );
  }
}
