import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_event_planner/core/api/api_client.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final VoidCallback onLogout;
  Completer<void>? _refreshCompleter;

  AuthInterceptor({required this.onLogout});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.read(key: 'access_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (err.requestOptions.path == '/auth/refresh') {
        await _logout();
        return handler.next(err);
      }

      if (_refreshCompleter != null) {
        await _refreshCompleter!.future;
        return handler.resolve(await ApiClient().dio.fetch(err.requestOptions));
      }

      _refreshCompleter = Completer();

      try {
        final refreshToken = await storage.read(key: 'refresh_token');
        if (refreshToken == null) throw Exception('No refresh token');

        // Use a new Dio instance to avoid interceptor loops
        final refreshDio =
            Dio(BaseOptions(baseUrl: err.requestOptions.baseUrl));
        final response = await refreshDio.post('/auth/refresh', data: {
          'refresh_token': refreshToken,
        });

        if (response.statusCode == 200) {
          await storage.write(
              key: 'access_token', value: response.data['access_token']);
          await storage.write(
              key: 'refresh_token', value: response.data['refresh_token']);
          _refreshCompleter?.complete();
          _refreshCompleter = null;
          return handler
              .resolve(await ApiClient().dio.fetch(err.requestOptions));
        } else {
          throw Exception('Refresh failed');
        }
      } catch (e) {
        _refreshCompleter?.completeError(e);
        await _logout();
        return handler.next(err);
      } finally {
        _refreshCompleter = null;
      }
    }
    super.onError(err, handler);
  }

  Future<void> _logout() async {
    await storage.deleteAll();
    onLogout();
  }
}