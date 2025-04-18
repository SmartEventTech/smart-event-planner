import 'dart:async';
import 'package:dio/dio.dart';
import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/storage/secure_storage.dart';
import 'package:smart_event_planner/core/utils/helpers/app_context.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _storage = getIt.get<SecureStorage>();
  final Dio _dio;

  AuthInterceptor(this._dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? newAccessToken = await _refreshToken();
      if (newAccessToken != null) {
        await _storage.saveToken(key: 'access_token', value: newAccessToken);
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        final cloneReq = await _dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(cloneReq);
      } else {
        _logout();
        return handler.reject(err);
      }
    } else {
      return handler.next(err);
    }
  }

  Future<String?> _refreshToken() async {
    try {
      String? refreshToken = await _storage.read(key: 'refresh_token');

      final response = await ApiClient().dio.post(
        'ce6e.up.railway.app/api/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        // save tokens
        await _storage.saveTokens(
          accessToken: response.data['data']['accessToken'],
          refreshToken: response.data['data']['refreshToken'] ??
              response.data['data']['accessToken'],
        );
        return response.data['data']['accessToken'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void _logout() async {
    var result = await getIt.get<AuthRepo>().logout();
    result.fold(
      (failure) => null,
      (_) => AppContext.context.pushNamedAndRemoveUntilPage(Routes.loginScreen),
    );
  }
}
