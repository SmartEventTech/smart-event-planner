import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/core/api/api_service.dart';
import 'package:smart_event_planner/core/cubits/otp_verification_cubit/cubit/otp_verification_cubit_state.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart'
    as auth_repo;

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final auth_repo.AuthRepo authRepo;
  final String email;
  final ApiServices apiService = ApiServices(ApiClient());

  OtpVerificationCubit({
    required this.authRepo,
    required this.email,
  }) : super(OtpVerificationInitial());

  Future<void> verifyOtp(String verificationCode, {bool reset = false}) async {
    emit(OtpVerificationLoading());
    try {
      final Either<dynamic, dynamic> result;
      if (!reset) {
        final confirmCode = int.tryParse(verificationCode.trim()) ?? 0;
        
        result = await authRepo.verifyUser(
          email: email,
          otp: confirmCode,
        );
      } else {
        final confirmCode = int.tryParse(verificationCode.trim()) ?? 0;

        result = await apiService.verifyResetPassword(
          email: email,
          otp: confirmCode,
        );
      }

      result.fold(
        (failure) => emit(OtpVerificationFailure(failure.message)),
        (user) => emit(OtpVerificationSuccess('Verification successful')),
      );
    } catch (e) {
      emit(OtpVerificationFailure(
          'An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> resendOtp(String email, {bool reset = false}) async {
    emit(ResndOtpLoading());
    var result = await getIt.get<auth_repo.AuthRepo>().sendOTP(email: email);
    result.fold(
      (failure) => emit(ResndOtpFailure(failure.message)),
      (_) {
        emit(ResndOtpSuccess('OTP sent successfully'));
      },
    );
  }
}
