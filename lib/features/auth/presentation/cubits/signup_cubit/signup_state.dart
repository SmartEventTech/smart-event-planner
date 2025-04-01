import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final String message;

  const SignupSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

class SignupErrorState extends SignupState {
  final String message;

  const SignupErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PrivacyValidationErrorState extends SignupState {
  final String errorMessage;

  const PrivacyValidationErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PasswordValidationErrorState extends SignupState {
  final String errorMessage;

  const PasswordValidationErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
