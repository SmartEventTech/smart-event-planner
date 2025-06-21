


import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProgressIndecator extends StatelessWidget {
  const ProgressIndecator({
    super.key,
    required int currentStep,
    required List<String> stepTitles,
  }) : _currentStep = currentStep, _stepTitles = stepTitles;

  final int _currentStep;
  final List<String> _stepTitles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultScreenPadding,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / _stepTitles.length,
            backgroundColor: Colors.grey.shade300,
            color: AppColors.secondaryColor,
            minHeight: 12,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _stepTitles[_currentStep],
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Step ${_currentStep + 1} of ${_stepTitles.length}',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}