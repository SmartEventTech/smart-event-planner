import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/screens/navigation_screen.dart';

class HobbyScreen extends StatefulWidget {
  const HobbyScreen({super.key});

  @override
  HobbyScreenState createState() => HobbyScreenState();
}

class HobbyScreenState extends State<HobbyScreen> {
  final List<String> interests = [
    'Cybersecurity',
    'UI/UX',
    'Fine Arts',
    'Data Analytics',
    'Web Development',
    'Music',
    'Photography',
    'Dance',
    'Cooking',
    'Painting',
    'Sports',
    'Fashion',
    'Fitness',
    'Travel',
    'Gardening',
    'Reading',
    'Language Learning',
    'Teaching',
    'Writing',
    'Physical Education',
    'Animal Care',
    'Science',
  ];

  final Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              'What are you interested in?',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select your favorite hobbies and majors to attend events',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Hobbies Grid
            Expanded(
              child: ListView(
                children: List.generate(
                  (interests.length / 2).ceil(),
                  (index) {
                    int firstIndex = index * 2;
                    int secondIndex = firstIndex + 1;
                    return Row(
                      children: [
                        buildHobbyContainer(interests[firstIndex]),
                        const SizedBox(
                          width: 10,
                        ), // Reduce spacing between two items
                        if (secondIndex < interests.length)
                          Expanded(
                              child:
                                  buildHobbyContainer(interests[secondIndex])),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.pushAndRemoveAll(NavigationScreen()),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromRGBO(15, 55, 124, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/icons/VectorArrow.png'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHobbyContainer(String interest) {
    final bool isSelected = selectedInterests.contains(interest);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected
              ? selectedInterests.remove(interest)
              : selectedInterests.add(interest);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 12), // Increased padding for better fit
        decoration: BoxDecoration(
          color:
              isSelected ? const Color.fromRGBO(15, 55, 124, 1) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                isSelected ? const Color.fromRGBO(15, 55, 124, 1) : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/Ellipse.png', width: 20, height: 20),
            const SizedBox(width: 8),
            Text(
              interest,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
