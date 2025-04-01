import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
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
  Future<Either<ApiError, void>> logout() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<ApiError, void>> signup({required SignupModel signupModel}) {
    return authRemoteDataSource.signup(signupModel);
  }

  @override
  Future<Either<ApiError, void>> resetPassword(
      {required String email,
      required String password,
      required String token}) {
    throw UnimplementedError();
  }
}
