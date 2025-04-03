import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 0),
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
          ),
        ],
      ),
    );
  }
}
