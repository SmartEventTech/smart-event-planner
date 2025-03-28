// otp_verification_state.dart


import 'package:equatable/equatable.dart';
import 'package:smart_event_planner/core/entities/user_entity.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState(); 

  @override
  List<Object> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {
  final UserEntity user;

  const OtpVerificationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class OtpVerificationFailure extends OtpVerificationState {
  final String message;

  const OtpVerificationFailure(this.message);

  @override
  List<Object> get props => [message];
}