import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/search/presentation/screens/custom_drawer.dart';
import 'package:smart_event_planner/features/search/presentation/widget/filter_events_list.dart';
import 'package:smart_event_planner/features/search/presentation/widget/screen_search_header.dart';

class SearchSecreen extends StatefulWidget {
  const SearchSecreen({super.key});

  @override
  State<SearchSecreen> createState() => _SearchSecreenState();
}

class _SearchSecreenState extends State<SearchSecreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.md),
            SearchScreenHeader(onFilterButtonPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },),
            const SizedBox(height: AppSizes.md),
            FilterEventsList(),
          ],
        ),
      ),
      endDrawer:  CustomDrawer(),
    );
  }
}

