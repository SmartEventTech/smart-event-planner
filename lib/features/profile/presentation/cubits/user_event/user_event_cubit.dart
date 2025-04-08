import 'package:bloc/bloc.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/core/api/retry_manger.dart';
import 'package:smart_event_planner/core/repositories/event_repository.dart';
import 'package:smart_event_planner/core/widgets/popups/loaders.dart';
import 'package:smart_event_planner/features/profile/domain/repositories/user_repo.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_event/user_event_state.dart';

class UserEventCubit extends Cubit<UserEventState> {
  final UserRepo _userRepo;
  final EventRepository _eventRepository = EventRepository();

  UserEventCubit(this._userRepo) : super(UserEventInitial());

  Future<void> fetchCustomizedEvents({bool forceRefresh = false}) async {
    // check if cubit not closed
    if (isClosed) return;
    // Return cached data if available and not forcing refresh
    if (!forceRefresh && _eventRepository.isCacheValid) {
      emit(UserEventLoaded(_eventRepository.events));
      return;
    }

    emit(UserEventLoading());

    final result = await _userRepo.getCustomizedEvents();

    result.fold((error) {
      if (error.message == "No internet connection" || error is NetworkError) {
        RetryManger.addToQueue(fetchCustomizedEvents);
      }
      emit(const UserEventError("Failed to load events"));
      Loaders.warningSnackBar(title: "Error", message: error.message);
    }, (events) {
      _eventRepository.updateCache(events);
      if (isClosed) return;
      emit(UserEventLoaded(events));
    });
  }

  // Call this when you know data might be stale
  void refreshEvents() {
    _eventRepository.clearCache();
    fetchCustomizedEvents();
  }
}
