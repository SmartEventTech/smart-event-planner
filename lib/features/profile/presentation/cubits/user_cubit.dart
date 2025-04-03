import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/features/profile/data/models/user_model.dart';
import 'package:smart_event_planner/features/profile/domain/repositories/user_repo.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitial());

  final UserRepo userRepo;

  UserModel user = UserModel.empty();
  String profelink = '';

  // get profile
  Future<void> getProfile() async {
    emit(UserLoadingState());
    final result = await userRepo.getProfile();
    result.fold(
      (error) => emit(
        UserErrorState(error.message),
      ),
      (userModel) {
        user = userModel;
        emit(UserLoadedState(userModel));
      },
    );
  }

  // // update profile
  // Future<void> updateProfile() async {
  //   emit(UserLoadingState());
  //   final result = await userRepo.updateProfile();
  //   result.fold((l) => emit(UserErrorState(l)), (r) => emit(UserLoadedState(r)));
  // }

  // share profile
  Future<String> shareProfile() async {
    final result = await userRepo.shareProfile();
    return result.fold(
      (error) {
        return error.message;
      },
      (link) {
        profelink = link;
        return link;
      },
    );
  }
}
