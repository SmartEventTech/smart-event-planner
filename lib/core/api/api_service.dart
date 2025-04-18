import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/storage/secure_storage.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/core/repositories/event_repository.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
import 'package:smart_event_planner/features/auth/data/models/signup_model.dart';
import 'package:smart_event_planner/features/profile/data/models/user_model.dart';
import 'package:smart_event_planner/features/auth/data/models/reset_passwor_model.dart';

class ApiServices {
  final ApiClient apiClient;

  final _storage = getIt.get<SecureStorage>();

  ApiServices(this.apiClient);

  // Get Token
  Future<String?> _getToken() async {
    return await _storage.getAccessToken();
  }

  // Get User Id
  Future<String?> _getUserId() async {
    return await _storage.getUserId();
  }

  /// Login
  Future<Either<ApiError, void>> login({required LoginModel loginModel}) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/login',
      method: 'POST',
      data: loginModel.toJson(),
    );

    return response.fold((error) {
      return Left(error);
    }, (response) async {
      // save tokens
      await _storage.saveTokens(
          accessToken: response.data['data']['accessToken'],
          refreshToken: response.data['data']['refreshToken'] ??
              response.data['data']['accessToken']);

      // save user id
      await _storage.saveUserId(response.data['data']['user']['_id']);

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
    }, (response) async {
      return const Right(null);
    });
  }

  /// Verify User
  Future<Either<ApiError, void>> verifyUser(
      {required String email, required int otp}) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/verifyUser',
      method: 'POST',
      data: {'email': email, 'confirmCode': otp},
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      // await _storage.saveTokens(
      //   accessToken: response.data['data']['accessToken'],
      //   refreshToken: response.data['data']['refreshToken'] ??
      //       response.data['data']['accessToken'],
      // );
      // await _storage.saveUserId(response.data['data']['user']['_id']);
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
    required int otp,
  }) async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/confirmPasswordResetCode',
      method: 'POST',
      data: {'email': email, 'confirmCode': otp},
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      return const Right(null);
    });
  }

  /// Logout
  Future<Either<ApiError, void>> logout() async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/logout',
      method: 'GET',
    );

    return response.fold((error) {
      return Left(error);
    }, (response) async {
      // delete tokens
      await _storage.deleteAllTokens();
      // delete user id
      await _storage.deleteUserId();
      // reset repo
      EventRepository().clearCache();

      return const Right(null);
    });
  }

  /// Send OTP
  Future<Either<ApiError, void>> sendOTP({required String email}) async {
    return await forgetPassword(email: email);
  }

  /// -----------User Profile-----------
  // Get User
  Future<Either<ApiError, UserModel>> getUser() async {
    // get user id
    final userId = await _getUserId();

    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/viewprofile/$userId',
      method: 'GET',
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      return Right(UserModel.fromJson(response.data));
    });
  }

  // Update User
  Future<Either<ApiError, UserModel>> updateProfile() async {
    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/updateprofile',
      method: 'PUT',
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response.data);
    });
  }

  // Share Profile
  Future<Either<ApiError, String>> shareProfile() async {
    // get user id
    final userId = await _getUserId();

    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/shareprofile/$userId/share',
      method: 'GET',
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response.data['link']);
    });
  }

  // Get Customized Events
  Future<Either<ApiError, List<EventModel>>> getCustomizedEvents() async {
    // get user id
    final userId = await _getUserId();

    final response = await apiClient.request(
      path: 'ce6e.up.railway.app/api/auth/viewprofilewithevent/$userId',
      // header
      headers: {'Authorization': 'Bearer ${await _getToken()}'},
      method: 'GET',
    );

    return response.fold((error) {
      return Left(error);
    }, (response) {
      final events = List.from(response.data['registeredEvents'])
          .map((e) => EventModel.fromJson(e))
          .toList();

      return Right(events);
    });
  }

  /// -----------":"-----------
}
