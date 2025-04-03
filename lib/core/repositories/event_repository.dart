import 'package:smart_event_planner/core/models/event/event_model.dart';

class EventRepository {
  // Private constructor
  EventRepository._internal();
  
  // Singleton instance
  static final EventRepository _instance = EventRepository._internal();
  
  // Factory constructor to return the same instance
  factory EventRepository() => _instance;
  
  // Cache state management
  bool _isFetched = false;
  DateTime? _lastFetchTime;
  List<EventModel> _cachedEvents = [];
  
  // Getter for cached events
  List<EventModel> get events => _cachedEvents;
  
  // Check if cache is still valid (optional: add expiry duration)
  bool get isCacheValid => _isFetched && 
      (_lastFetchTime == null || 
       DateTime.now().difference(_lastFetchTime!) < const Duration(hours: 1));
  
  // Update cache
  void updateCache(List<EventModel> events) {
    _cachedEvents = events;
    _isFetched = true;
    _lastFetchTime = DateTime.now();
  }
  
  // Clear cache (call this when you need fresh data)
  void clearCache() {
    _cachedEvents = [];
    _isFetched = false;
    _lastFetchTime = null;
  }
}