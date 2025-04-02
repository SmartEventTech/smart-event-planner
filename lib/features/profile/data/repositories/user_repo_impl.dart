import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/api/api_error.dart';
import 'package:smart_event_planner/features/profile/data/datasources/profile_remote_data_souces.dart';
import 'package:smart_event_planner/features/profile/data/models/user_model.dart';
import 'package:smart_event_planner/features/profile/domain/repositories/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  UserRepoImpl(this.profileRemoteDataSource);

  @override
  Future<Either<ApiError, UserModel>> getProfile() async {
    return await profileRemoteDataSource.getProfile();
  }

  @override
  Future<Either<ApiError, String>> shareProfile() async {
    return await profileRemoteDataSource.shareProfile();
  }

  @override
  Future<Either<ApiError, UserModel>> updateProfile() async {
    return await profileRemoteDataSource.updateProfile();
  }
}
