import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/core/api/api_service.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
import 'package:smart_event_planner/features/auth/data/models/signup_model.dart';

abstract class AuthRemoteDataSource {
  // login
  Future<Either<ApiError, void>> login(LoginModel loginModel);
  // register
  Future<Either<ApiError, void>> signup(SignupModel signupModel);

  // logout

  // reset password
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices apiService;

  AuthRemoteDataSourceImpl(this.apiService);
  @override
  Future<Either<ApiError, void>> login(LoginModel loginModel) async {
    var result = await apiService.login(loginModel: loginModel);

    return result;
  }

  @override
  Future<Either<ApiError, void>> signup(SignupModel signupModel) async {
    return await apiService.signup(signupModel: signupModel);
  }
}
