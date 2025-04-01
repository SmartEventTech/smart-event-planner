import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/core/cubits/otp_verification_cubit/cubit/otp_verification_cubit_state.dart';
import 'package:smart_event_planner/core/repos/auth_repo/auth_repo.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final AuthRepo authRepo;
  final String email;

  OtpVerificationCubit({
    required this.authRepo,
    required this.email,
  }) : super(OtpVerificationInitial());

  Future<void> verifyOtp(String verificationCode) async {
    emit(OtpVerificationLoading());
    try {
      final result = await authRepo.verifyUser(
        email: email,
        verificationCode: verificationCode, 
      );

      result.fold(
        (failure) => emit(OtpVerificationFailure(failure.message)),
        (user) => emit(OtpVerificationSuccess(user)),
      );
    } catch (e) {
      emit(OtpVerificationFailure('An unexpected error occurred. Please try again.'));
    }
  }
}