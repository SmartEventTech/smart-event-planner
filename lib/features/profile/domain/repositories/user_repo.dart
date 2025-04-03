import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/features/profile/data/models/user_model.dart';

abstract class UserRepo {
  // get profile
  Future<Either<ApiError, UserModel>> getProfile();

  // update profile
  Future<Either<ApiError, UserModel>> updateProfile();

  // share profile
  Future<Either<ApiError, String>> shareProfile();

  // get customized events
  Future<Either<ApiError, List<EventModel>>> getCustomizedEvents();
}
