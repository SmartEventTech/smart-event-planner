import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/cubit/bottom_nav_cubit.dart';
import 'package:smart_event_planner/features/home/presentation/screens/home_screen.dart';
import 'package:smart_event_planner/features/search/presentation/screens/search_secreen.dart';

class NavigationScreenBody extends StatelessWidget {
  const NavigationScreenBody({super.key});

  static final List<Widget> _screens = [
    HomeScreen(),
    //Another screens
    SearchSecreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return _screens[state];
      },
    );
  }
}
