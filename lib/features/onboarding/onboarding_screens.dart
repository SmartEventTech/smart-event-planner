import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/features/widgets/onboarding_widget.dart';

class OnboardingScreens extends StatefulWidget {
  static const String id = Routes.onboardingScreen;

  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => OnboardingScreensState();
}

class OnboardingScreensState extends State<OnboardingScreens> {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<Widget> onboardingPages = [
    const OnboardingPage(
      imagePath: 'assets/images/onboarding1.png',
      description: 'Find events with people that match your interests.',
    ),
    const OnboardingPage(
      imagePath: 'assets/images/onboarding2.png',
      description: 'Create your own event and invite your friends.',
    ),
    const OnboardingPage(
      imagePath: 'assets/images/onboarding3.png',
      description: 'Get event recommendations based on your location.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: onboardingPages,
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingPages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  width: 30,
                  height: 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: currentPage == index
                        ? Color.fromRGBO(160, 6, 81, 1)
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          if (currentPage == onboardingPages.length - 1)
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color.fromRGBO(1, 48, 90, 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 88,
                      vertical: 8.5,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginScreen);
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
