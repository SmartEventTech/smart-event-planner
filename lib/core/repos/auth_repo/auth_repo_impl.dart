import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:smart_event_planner/core/entities/user_entity.dart';
import 'package:smart_event_planner/core/errors/exceptions.dart';
import 'package:smart_event_planner/core/errors/failures.dart' ;
import 'package:smart_event_planner/core/models/user_model.dart';
import 'package:smart_event_planner/core/repos/auth_repo/auth_repo.dart';
import 'package:smart_event_planner/core/services/api_service.dart';

class AuthRepoImplementation implements AuthRepo {
  final ApiService apiService;
  final Logger logger;

  AuthRepoImplementation({
    required this.apiService,
    required this.logger,
  });

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (name.isEmpty) {
        return Left(ServerFailure(message: "Name cannot be empty"));
      }

      logger.d('Attempting to register user: $email');
      
      final response = await apiService.post(
        endpoint: '/auth/register',
        data: {
          'email': email.trim(),
          'password': password.trim(),
          'name': name.trim(),
        },
      );

      if (response['status'] != 'success') {
        final errorMsg = response['message'] ?? 'Registration failed';
        logger.e('Registration failed: $errorMsg');
        return Left(ServerFailure(message: errorMsg));
      }

      logger.i('User registration successful for: $email');
      final userData = response['data'] as Map<String, dynamic>;
      final userEntity = UserModel.fromJson(userData).toEntity();
      
      return Right(userEntity);
    } on ServerException catch (e) {
      logger.e('Registration failed for $email: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e, stackTrace) {
      logger.e('Unexpected registration error', error: e, stackTrace: stackTrace);
      return Left(ServerFailure(
          message: 'Registration failed. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      logger.d('Attempting login for: $email');
      
      final response = await apiService.post(
        endpoint: '/auth/login',
        data: {
          'email': email.trim(),
          'password': password.trim(),
        },
      );

      if (response['status'] != 'success') {
        final errorMsg = response['message'] ?? 'Login failed';
        logger.e('Login failed: $errorMsg');
        return Left(ServerFailure(message: errorMsg));
      }

      logger.i('Login successful for: $email');
      final userData = response['data'] as Map<String, dynamic>;
      final userEntity = UserModel.fromJson(userData).toEntity();
      return Right(userEntity);
    } on ServerException catch (e) {
      logger.e('Login failed for $email: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e, stackTrace) {
      logger.e('Unexpected login error', error: e, stackTrace: stackTrace);
      return Left(ServerFailure(
          message: 'Login failed. Please try again.'));
    }
  }
@override
Future<Either<Failure, UserEntity>> verifyUser({
  required String email,
  required String verificationCode,
}) async {
  try {
    logger.d('Attempting to verify user: $email with code: $verificationCode');
    
    // Convert verificationCode to integer
    final confirmCode = int.tryParse(verificationCode.trim());
    if (confirmCode == null) {
      return Left(ServerFailure(message: 'Invalid OTP format'));
    }

    final response = await apiService.post(
      endpoint: '/auth/verifyUser',
      data: {
        'email': email.trim(),
        'confirmCode': confirmCode, 
      },
    );

    logger.d('Verification response: ${response.toString()}');

    if (response['status'] != 'success') {
      final errorMsg = response['message'] ?? 'Verification failed';
      logger.e('Verification failed: $errorMsg');
      return Left(ServerFailure(message: errorMsg));
    }

    logger.i('User verification successful for: $email');
    
    // Handle null data case
    if (response['data'] == null) {
      // Return a UserEntity with just the email if no data is provided
      return Right(UserEntity(
        email: email,
        // Add other required fields with default values
        
        name: '', uId: '',
        // ... other required fields
      ));
    }

    // If data exists, parse it normally
    final userData = response['data'] as Map<String, dynamic>;
    final userEntity = UserModel.fromJson(userData).toEntity();
    
    return Right(userEntity);
  } on DioException catch (e) {
    logger.e('Dio error during verification: ${e.message}');
    return Left(ServerFailure(message: 'Network error occurred'));
  } catch (e, stackTrace) {
    logger.e('Unexpected verification error', error: e, stackTrace: stackTrace);
    return Left(ServerFailure(message: 'An unexpected error occurred'));
  }
}
  @override
  Future<Either<Failure, void>> addUserData({
    required UserEntity user,
  }) async {
    try {
      logger.d('Adding user data for: ${user.email}');
      
      final response = await apiService.post(
        endpoint: '/users',
        data: UserModel.fromEntity(user).toJson(),
      );

      if (response['status'] != 'success') {
        final errorMsg = response['message'] ?? 'Failed to save user data';
        logger.e('Failed to add user data: $errorMsg');
        return Left(ServerFailure(message: errorMsg));
      }

      logger.i('User data added successfully for: ${user.email}');
      return const Right(null);
    } on ServerException catch (e) {
      logger.e('Failed to add user data: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e, stackTrace) {
      logger.e('Unexpected error adding user data',
          error: e, stackTrace: stackTrace);
      return Left(ServerFailure(
          message: 'Failed to save user data. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData({
    required String uid,
  }) async {
    try {
      logger.d('Fetching user data for ID: $uid');
      
      final response = await apiService.get('/users/$uid');

      if (response['status'] != 'success') {
        final errorMsg = response['message'] ?? 'Failed to fetch user data';
        logger.e('Failed to fetch user data: $errorMsg');
        return Left(ServerFailure(message: errorMsg));
      }

      logger.i('Successfully fetched user data for ID: $uid');
      final userData = response['data'] as Map<String, dynamic>;
      return Right(UserModel.fromJson(userData).toEntity());
    } on ServerException catch (e) {
      logger.e('Failed to fetch user data: ${e.message}');
      return Left(ServerFailure(message: e.message));
    } catch (e, stackTrace) {
      logger.e('Unexpected error fetching user data',
          error: e, stackTrace: stackTrace);
      return Left(ServerFailure(
          message: 'Failed to load user data. Please try again later.'));
    }
  }

@override
// ignore: override_on_non_overriding_member
Future<Either<Failure, void>> deleteUser(String userId) async {
  try {
    logger.d('Deleting user with ID: $userId');
    
    // Now this returns Map<String, dynamic> instead of void
    final response = await apiService.delete(endpoint: '/users/$userId');

    if (response['status'] != 'success') {
      final errorMsg = response['message'] ?? 'Failed to delete user';
      logger.e('Failed to delete user: $errorMsg');
      return Left(ServerFailure(message: errorMsg));
    }

    logger.i('Successfully deleted user with ID: $userId');
    return const Right(null);
  } on ServerException catch (e) {
    logger.e('Failed to delete user: ${e.message}');
    return Left(ServerFailure(message: e.message));
  } catch (e, stackTrace) {
    logger.e('Unexpected error deleting user',
        error: e, stackTrace: stackTrace);
    return Left(ServerFailure(
        message: 'Failed to delete user. Please try again later.'));
  }
}

  @override
  Future<Either<Failure, void>> signOut() async {
    logger.i('User signed out');
    return const Right(null);
  }
}