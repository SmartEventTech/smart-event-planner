import 'package:equatable/equatable.dart';
import 'package:smart_event_planner/features/profile/data/models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel userModel;

  UserLoadedState(this.userModel);

  @override
  List<Object?> get props => [userModel];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);
}


class SharePofileState extends UserState {
  final String link;

  SharePofileState(this.link);
}
