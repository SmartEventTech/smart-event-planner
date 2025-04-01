import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
import 'package:smart_event_planner/features/auth/data/models/reset_passwor_model.dart';
import 'package:smart_event_planner/features/auth/data/models/signup_model.dart';

abstract class AuthRepo {
  // login
  Future<Either<ApiError, void>> login({required LoginModel loginModel});

  // register
  Future<Either<ApiError, void>> signup({required SignupModel signupModel});

  // logout
  Future<Either<ApiError, void>> logout();

  // register
  Future<Either<ApiError, void>> forgetPassword({required String email});

  // reset password
  Future<Either<ApiError, void>> resetPassword(
      {required ResetPassworModel resetPassworModel});
}
