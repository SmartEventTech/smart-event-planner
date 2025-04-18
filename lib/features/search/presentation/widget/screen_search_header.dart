import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';

class SearchScreenHeader extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterButtonPressed;
  final List<String> activeFilters;
  final VoidCallback onClearFilters;

  const SearchScreenHeader({
    super.key,
    required this.controller,
    required this.onFilterButtonPressed,
    required this.activeFilters,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: AppColors.secondaryColor),
                    hintText: 'Search events...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onFilterButtonPressed,
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  size: 30,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
          if (activeFilters.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Active filters:',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onClearFilters,
                  child: const Text(
                    'Clear all',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
