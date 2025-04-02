// # Create a singleton ApiClient to manage the Dio instance and interceptors.

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/core/api/interceptors/auth_interceptor.dart';
import 'package:smart_event_planner/core/api/interceptors/connectivity_interceptor.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late Dio dio;

  // Callback for logout
  VoidCallback? onLogout;

  // Get Base URL with HTTPS validation
  String baseUrl(String key) {
    try {
      final url = dotenv.get(key);
      // Validate HTTPS URLs
      if (!url.startsWith('https://')) {
        throw Exception('Invalid HTTPS URL in .env: $key');
      }
      return url;
    } catch (e) {
      throw Exception('Dotenv key not found: $key');
    }
  }

  String get baseUrlLink => baseUrl('BASE_URL');

  ApiClient._internal() {
    // Initialize Dio with security settings
    dio = Dio(BaseOptions(
      baseUrl: baseUrlLink,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    // Enable certificate pinning in production
    if (!kDebugMode) {
      _enableCertificatePinning();
    }

    // Add interceptors
    dio.interceptors.addAll([
      // Connectivity interceptor
      ConnectivityInterceptor(),
      // Auth interceptor
      AuthInterceptor(onLogout: getIt<AuthRepo>().logout),
      // Retry interceptor
      _retryInterceptor(),

      // Log interceptor
      LogInterceptor(
        responseBody: kDebugMode,
        request: kDebugMode,
        error: kDebugMode,
        requestHeader: kDebugMode,
      ),
    ]);
  }

  // Retry Interceptor
  Interceptor _retryInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (_shouldRetry(error)) {
          await Future.delayed(const Duration(seconds: 1));
          try {
            return handler.resolve(await dio.fetch(error.requestOptions));
          } catch (e) {
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    );
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.response?.statusCode == 502;
  }

  // Method to make API requests
  Future<Either<ApiError, Response>> request({
    required String path,
    String? baseUrl,
    Object? data,
    Map<String, dynamic>? queryParameters,
    String method = 'GET',
  }) async {
    try {
      dio.options.baseUrl = baseUrl ?? baseUrlLink;
      final response = await dio.request(
        path,
        data: data,
        options: Options(method: method),
        queryParameters: queryParameters,
      );

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  // Certificate Pinning
  void _enableCertificatePinning() {
    final httpClientAdapter = dio.httpClientAdapter;
    if (httpClientAdapter is IOHttpClientAdapter) {
      httpClientAdapter.createHttpClient = (client) {
        final SecurityContext ctx = SecurityContext();
        // Add your certificate(s) here
        // ctx.setTrustedCertificatesBytes(await rootBundle.load('certificate.pem'));
        return HttpClient(context: ctx);
      } as CreateHttpClient?;
    }
  }
}
