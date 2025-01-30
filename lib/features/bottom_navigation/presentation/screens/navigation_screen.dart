import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/cubit/bottom_nav_cubit.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/widgets/navigation_screen_body.dart';
import 'package:smart_event_planner/shared/widgets/appBar/custom_bottom_naviagtion_bar.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        body: NavigationScreenBody(),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
