import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/home/presentation/widgets/interested_section/interested_card.dart';

class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: GridView.builder(
        itemCount: 8,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) => InterestedCard(),
      ),
    );
  }
}
