
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:smart_event_planner/core/cubits/signup_cubit/signup_state.dart';
import 'package:smart_event_planner/core/errors/failures.dart';
import 'package:smart_event_planner/core/repos/auth_repo/auth_repo.dart';


class SignupCubit extends Cubit<SignupState> {
  final AuthRepo authRepo;

  SignupCubit({required this.authRepo}) : super(SignupInitial());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignupLoading());
    try {
      final result = await authRepo.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      result.fold(
        (failure) => emit(SignupFailure(message: _mapFailureToMessage(failure))),
        (userEntity) => emit(SignupSuccess(userEntity: userEntity)),
      );
    } catch (e) {
      emit(SignupFailure(message: _mapExceptionToMessage(e)));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return 'Network error: ${failure.message}';
    }
    return 'An unexpected error occurred';
  }

  String _mapExceptionToMessage(dynamic e) {
    if (e is SocketException) {
      return 'Network error: Please check your internet connection';
    } else if (e is TimeoutException) {
      return 'Request timeout: Server took too long to respond';
    }
    return 'An unexpected error occurred';
  }
}