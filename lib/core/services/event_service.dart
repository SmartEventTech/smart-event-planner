import 'package:dio/dio.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';

class EventService {
  final Dio _dio;

  EventService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://eventplanner-production-ce6e.up.railway.app/api',
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
          ),
        ){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] =
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2N2M4NDJmMmY4NWUxOGM5MTVkN2IxNzciLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3NDQ5OTA1MTYsImV4cCI6MTc0NzU4MjUxNn0.HM3HAGLTr4jHplhnHOimWr32zRru7t4SJrTncG98suc';
        options.headers['Content-Type'] = 'application/json';
        options.headers['Accept'] = 'application/json';
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
        }
        return handler.next(error);
      },
    ));
  }

  Future<List<EventModel>> getEvents() async {
    try {
      final response = await _dio.get('/events/getevents');

      if (response.statusCode == 200) {

        dynamic responseData = response.data;

        if (responseData is Map) {
          if (responseData['data'] is List) {
            return _parseEvents(responseData['data']);
          } else if (responseData['events'] is List) {
            return _parseEvents(responseData['events']);
          } else if (responseData['items'] is List) {
            return _parseEvents(responseData['items']);
          }
        } else if (responseData is List) {
          return _parseEvents(responseData);
        }

        throw Exception('Invalid API response format');
      } else {
        throw Exception(
            'API request failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
      }
      throw Exception('Failed to fetch events: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }

  List<EventModel> _parseEvents(List<dynamic> eventsList) {
    try {
      return eventsList.map((eventJson) {
        try {
          return EventModel.fromJson(eventJson);
        } catch (e) {
          throw Exception('Failed to parse event data');
        }
      }).toList();
    } catch (e) {
      throw Exception('Failed to parse events list');
    }
  }
}
