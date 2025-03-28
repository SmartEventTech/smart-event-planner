import 'package:equatable/equatable.dart';
import 'package:smart_event_planner/core/entities/user_entity.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final UserEntity userEntity;

  const SignInSuccess({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

class SignInFailure extends SignInState {
  final String message;

  const SignInFailure({required this.message});

  @override
  List<Object> get props => [message];
}