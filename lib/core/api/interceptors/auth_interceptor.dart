import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/core/utils/helpers/app_context.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio _dio;

  AuthInterceptor(this._dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.read(key: 'access_token');
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
        await storage.write(key: 'access_token', value: newAccessToken);
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
      String? refreshToken = await storage.read(key: 'refresh_token');

      if (refreshToken == null) return null;

      final response = await ApiClient().dio.post(
        'ce6e.up.railway.app/api/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        await storage.write(
            key: 'access_token', value: response.data['data']['accessToken']);
        await storage.write(
            key: 'refresh_token', value: response.data['data']['refreshToken']);
        return response.data['data']['accessToken'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void _logout() async {
    await getIt.get<AuthRepo>().logout();
    storage.delete(key: 'access_token');
    storage.delete(key: 'refresh_token');
    if (AppContext.context.mounted) {
      AppContext.context.pushNamedAndRemoveUntilPage(Routes.loginScreen);
    }
  }
}
