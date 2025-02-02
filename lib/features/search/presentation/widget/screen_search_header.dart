import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';

class SearchScreenHeader extends StatelessWidget {
  const SearchScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 56.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search',
                prefixIcon: Icon(
                  Iconsax.search_normal,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppImages.filterIcon),
          )
        ],
      ),
    );
  }
}
