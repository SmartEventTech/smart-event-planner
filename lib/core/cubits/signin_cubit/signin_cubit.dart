import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/cubits/signin_cubit/signin_state.dart';
import 'package:smart_event_planner/core/errors/failures.dart';
import 'package:smart_event_planner/core/repos/auth_repo/auth_repo.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;

  SignInCubit({required this.authRepo}) : super(SignInInitial());

  // controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(SignInLoading());
    try {
      final result = await authRepo.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (failure) =>
            emit(SignInFailure(message: _mapFailureToMessage(failure))),
        (userEntity) => emit(SignInSuccess(userEntity: userEntity)),
      );
    } catch (e) {
      emit(SignInFailure(message: _mapExceptionToMessage(e)));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return 'Network error: ${failure.message}';
    } else if (failure is ValidationFailure) {
      return 'Invalid email or password';
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

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
