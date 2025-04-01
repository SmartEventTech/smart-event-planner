import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
import 'package:smart_event_planner/features/auth/data/models/signup_model.dart';

class ApiServices {
  final ApiClient apiClient;

  final _storage = const FlutterSecureStorage();

  ApiServices(this.apiClient);

  /// Login
  Future<Either<ApiError, void>> login({required LoginModel loginModel}) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/login',
      method: 'POST',
      data: loginModel.toJson(),
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      _storage.write(key: 'access_token', value: response.data['data']['accessToken']);
      return const Right(null);
    });
  }

  /// Register
  Future<Either<ApiError, void>> signup(
      {required SignupModel signupModel}) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/register',
      method: 'POST',
      data: signupModel.toJson(),
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      _storage.write(key: 'access_token', value: response.data['data']['accessToken']);
      return const Right(null);
    });
  }
}
