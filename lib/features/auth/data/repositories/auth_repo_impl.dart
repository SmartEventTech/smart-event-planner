import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
import 'package:smart_event_planner/features/auth/data/models/reset_passwor_model.dart';
import 'package:smart_event_planner/features/auth/data/models/signup_model.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);
  @override
  Future<Either<ApiError, void>> login({required LoginModel loginModel}) async {
    return await authRemoteDataSource.login(loginModel);
  }

  @override
  Future<void> logout() async {
    return await authRemoteDataSource.logout();
  }

  @override
  Future<Either<ApiError, void>> signup({required SignupModel signupModel}) {
    return authRemoteDataSource.signup(signupModel);
  }

  @override
  Future<Either<ApiError, void>> forgetPassword({required String email}) {
    return authRemoteDataSource.forgetPassword(email: email);
  }

  @override
  Future<Either<ApiError, void>> resetPassword(
      {required ResetPassworModel resetPassworModel}) {
    return authRemoteDataSource.resetPassword(resetPassworModel);
  }

  @override
  Future<Either<ApiError, void>> sendOTP({required String email}) async {
    return await authRemoteDataSource.sendOTP(email: email);
  }
}
