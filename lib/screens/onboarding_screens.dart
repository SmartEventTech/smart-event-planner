import 'package:flutter/material.dart';

class OnboardingScreens extends StatefulWidget {
  static const String id = 'OnboardingScreens';
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of onboarding screens
  final List<Widget> _onboardingPages = [
    const OnboardingPage(
      imagePath: 'assets/images/onboarding1.png',
      description: 'Find events with people that matches your interests.',
    ),
    const OnboardingPage(
      imagePath: 'assets/images/onboarding2.png',
      description: 'Create your own event and invite your friends.',
    ),
    const OnboardingPage(
      imagePath: 'assets/images/onboarding3.png',
      description:
          'Provided by your location you will get events recommendation .',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for swipeable screens
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _onboardingPages,
          ),

          // Indicator at the bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingPages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  width: 30,
                  height: 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _currentPage == index
                        ? Color.fromRGBO(160, 6, 81, 1)
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          // "Get Started" button on the last screen
          if (_currentPage == _onboardingPages.length - 1)
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
                    // Navigate to the home screen or main app screen
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Reusable onboarding page widget
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 0),
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color.fromRGBO(1, 48, 90, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
