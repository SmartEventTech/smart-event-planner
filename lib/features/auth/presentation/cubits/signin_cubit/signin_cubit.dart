import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/storage/app_storage.dart';
import 'package:smart_event_planner/features/auth/data/models/login_model.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart'
    show AuthRepo;
import 'package:smart_event_planner/features/auth/presentation/cubits/signin_cubit/signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;

  SignInCubit({required this.authRepo}) : super(SignInInitial());

  // Storage
  final _storage = AppStorage();

  // controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // show email and password that is storage in get storage
  void getStorageEmailAndPassword() {
    emailController.text = _storage.getString('REMEMBER_ME_EMAIL');
    passwordController.text = _storage.getString('REMEMBER_ME_PASSWORD');
  }

  Future<void> signInWithEmailAndPassword(isRememberMe) async {
    if (!validateForm()) return;

    emit(SignInLoading());

    // handle remember me
    if (isRememberMe) {
      _storage.setString('REMEMBER_ME_EMAIL', emailController.text.trim());
      _storage.setString(
          'REMEMBER_ME_PASSWORD', passwordController.text.trim());
    } else {
      _storage.remove('REMEMBER_ME_EMAIL');
      _storage.remove('REMEMBER_ME_PASSWORD');
    }

    // Construct user creation model
    final user = LoginModel(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    final result = await authRepo.login(
      loginModel: user,
    );

    result.fold(
      (failure) => emit(SignInFailure(message: failure.toString())),
      (_) => emit(SignInSuccess('Successfully Login in')),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
