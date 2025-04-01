import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return handler.reject(DioException(
        requestOptions: options,
        error: 'No internet',
        message: 'Please check your internet connection.',
      ));
    }
    super.onRequest(options, handler);
  }
}
