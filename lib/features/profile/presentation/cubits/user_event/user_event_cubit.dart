import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_event_planner/features/profile/domain/repositories/user_repo.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_event/user_event_state.dart';

class UserEventCubit extends Cubit<UserEventState> {
  UserEventCubit(this.userRepo) : super(UserEventInitial());

  final UserRepo userRepo;

  // Fetch customized events
  void fetchCustomizedEvents() async {
    debugPrint('fetchCustomizedEvents');
    emit(UserEventLoading());

    var result = await userRepo.getCustomizedEvents();

    result.fold(
      (error) => emit(UserEventError(error.message)),
      (events) => emit(UserEventLoaded(events)),
    );
  }

  // Fetch favourite events
  void fetchFavouriteEvents() {
    emit(FavouriteEventLoading());
  }
}
