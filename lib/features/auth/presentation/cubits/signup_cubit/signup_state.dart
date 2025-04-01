

import 'package:equatable/equatable.dart';
import 'package:smart_event_planner/core/entities/user_entity.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final UserEntity userEntity;

  const SignupSuccess({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

class SignupFailure extends SignupState {
  final String message;

  const SignupFailure({required this.message});

  @override
  List<Object> get props => [message];
}