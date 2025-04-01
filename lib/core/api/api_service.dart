import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
import 'package:smart_event_planner/features/auth/data/models/reset_passwor_model.dart';
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
      _storage.write(
          key: 'access_token', value: response.data['data']['accessToken']);
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
      _storage.write(
          key: 'access_token', value: response.data['data']['accessToken']);
      return const Right(null);
    });
  }

  /// Forgot Password
  Future<Either<ApiError, void>> forgetPassword({required String email}) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/forgotpassword',
      method: 'POST',
      data: {'email': email},
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      return const Right(null);
    });
  }

  /// Reset Password
  Future<Either<ApiError, void>> restPassword(
      {required ResetPassworModel resetPassworModel}) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/passwordReset',
      method: 'POST',
      data: resetPassworModel.toJson(),
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      return const Right(null);
    });
  }

  /// Verify Reset Password
  Future<Either<ApiError, void>> verifyResetPassword({
    required String email,
    required int verificationCode,
  }) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/confirmPasswordResetCode',
      method: 'POST',
      data: {'email': email, 'confirmCode': verificationCode},
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      return const Right(null);
    });
  }

  /// Logout
  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
  }
}
