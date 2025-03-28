import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_event_planner/core/errors/exceptions.dart';

class ApiService {
  final Dio dio;
  final Connectivity connectivity;

  ApiService({
    required this.dio,
    required this.connectivity,
  }) {
    // Configure Dio instance
    dio.options = BaseOptions(
      baseUrl: 'https://eventplanner-production-b14f.up.railway.app/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        throw ServerException('No internet connection');
      }

      final response = await dio.get(endpoint);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        throw ServerException('No internet connection');
      }

      final response = await dio.post(endpoint, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }

Future<Map<String, dynamic>> delete({
  required String endpoint,
}) async {
  try {
    final response = await dio.delete(endpoint);
    return response.data as Map<String, dynamic>; // Return the response
  } on DioException catch (e) {
    throw ServerException.fromDioError(e);
  }
}
}