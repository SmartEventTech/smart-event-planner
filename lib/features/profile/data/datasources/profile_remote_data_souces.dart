import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/core/api/api_service.dart';
import 'package:smart_event_planner/features/profile/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  // Get profile
  Future<Either<ApiError, UserModel>> getProfile();

  // Update profile
  Future<Either<ApiError, UserModel>> updateProfile();

  // Share profile
  Future<Either<ApiError, String>> shareProfile();

  //
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiServices apiService;

  ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<ApiError, UserModel>> getProfile() async {
    return await apiService.getUser();
  }

  @override
  Future<Either<ApiError, String>> shareProfile() async {
    return await apiService.shareProfile();
  }

  @override
  Future<Either<ApiError, UserModel>> updateProfile() async {
    return await apiService.updateProfile();
  }
}
