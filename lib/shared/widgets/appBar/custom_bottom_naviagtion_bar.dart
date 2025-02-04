import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/shared/widgets/appBar/bottom_nav_bar_plus_icon.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/cubit/bottom_nav_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            NavigationBar(
              height: 62,
              selectedIndex: state,
              onDestinationSelected: (index) =>
                  context.read<BottomNavCubit>().changeTab(index),
              destinations: [
                NavigationDestination(
                  icon: Icon(Iconsax.home),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.search_normal),
                  label: "Search",
                ),
                NavigationDestination(
                  icon: SizedBox(),
                  label: "",
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.calendar),
                  label: "Sceduale",
                ),
                NavigationDestination(
                  icon: Icon(Iconsax.user),
                  label: "Profile",
                ),
              ],
            ),
            BottomNavBarPlusIcon(),
          ],
        );
      },
    );
  }
}
