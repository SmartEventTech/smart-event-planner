import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/widgets/shimmer/shimmer_widget.dart';
import 'package:smart_event_planner/shared/widgets/events/events_list_view.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_event/user_event_cubit.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_event/user_event_state.dart';

class BuildCustomizedEventList extends StatelessWidget {
  const BuildCustomizedEventList({super.key, required events});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEventCubit, UserEventState>(
      buildWhen: (previous, current) =>
          current is UserEventLoaded ||
          current is UserEventLoading ||
          current is UserEventError,
      builder: (context, state) {
        if (state is UserEventLoaded) {
          if (state.events.isEmpty) {
            return const Center(child: Text("No events found"));
          }
          return EventsListView(
            events: [...state.events],
          );
        } else if (state is UserEventLoading) {
          return _buildShimmerEventCard();
        }

        return _buildShimmerEventCard();
      },
    );
  }

  _buildShimmerEventCard() {
    return ListView.separated(
      itemCount: 4,
      itemBuilder: (context, index) => AspectRatio(
        aspectRatio: 352 / 151,
        child: ShimmerWidget(
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
    );
  }
}
