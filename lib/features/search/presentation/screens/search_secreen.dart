import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/search/presentation/widget/filter_events_list.dart';
import 'package:smart_event_planner/features/search/presentation/widget/screen_search_header.dart';

class SearchSecreen extends StatelessWidget {
  const SearchSecreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
        ),
        child: Column(
          children: [
            SearchScreenHeader(),
            FilterEventsList(),
          ],
        ),
      ),
    );
  }
}
