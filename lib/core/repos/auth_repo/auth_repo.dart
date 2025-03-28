import 'package:dartz/dartz.dart';
import 'package:smart_event_planner/core/entities/user_entity.dart';
import 'package:smart_event_planner/core/errors/failures.dart';


abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> addUserData({
    required UserEntity user,
  });

  Future<Either<Failure, UserEntity>> getUserData({
    required String uid,
  });

  Future<Either<Failure, void>> signOut();
}