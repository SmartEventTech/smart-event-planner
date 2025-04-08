import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/interested_section/interested_card.dart';

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.23,
      child: GridView.builder(
        itemCount: 8,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) => const InterestedCard(),
      ),
    );
  }
}
