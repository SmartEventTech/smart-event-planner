import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/create_event_section.dart';

class SuggestedEventsSection extends StatelessWidget {
  const SuggestedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItem),
          child: CreateEventSection(),
        ),
        childCount: 4,
      ),
    );
  }
}
