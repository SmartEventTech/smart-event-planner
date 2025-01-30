import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(22),
        topLeft: Radius.circular(22),
      ),
      child: NavigationBar(
        backgroundColor: Colors.white,
        height: 65,
        elevation: 2,
        shadowColor: Colors.black,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Iconsax.search_normal), label: 'Search'),
          NavigationDestination(
              icon: Icon(Iconsax.calendar), label: 'Schedule'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}