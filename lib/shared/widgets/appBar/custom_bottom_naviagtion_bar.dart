import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/bottom_navigation/presentation/cubit/bottom_nav_cubit.dart';
import 'package:smart_event_planner/shared/widgets/appBar/bottom_nav_bar_plus_icon.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.btnNavBarRadius),
                topRight: Radius.circular(AppSizes.btnNavBarRadius),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: AppColors.blueTextColor,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: state,
                onTap: (index) =>
                    context.read<BottomNavCubit>().changeTab(index),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.search_normal),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.calendar),
                    label: "Schedule",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.user),
                    label: "Profile",
                  ),
                ],
              ),
            ),
            BottomNavBarPlusIcon(),
          ],
        );
      },
    );
  }
}
