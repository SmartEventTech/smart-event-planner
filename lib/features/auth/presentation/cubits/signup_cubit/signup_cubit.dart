import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/auth/data/models/signup_model.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo authRepo;

  SignupCubit({required this.authRepo}) : super(SignupInitial());

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signup(isPrivacyAccepted) async {
    // Validation
    if (!validateForm()) return;

    // password and confirm password
    if (passwordController.text != confirmPasswordController.text) {
      emit(
        const PasswordValidationErrorState(
          'Password and Confirm Password must be same',
        ),
      );
      return;
    }

    // handle privacy accepted
    if (!isPrivacyAccepted) {
      emit(
        const PrivacyValidationErrorState(
          'In order create account, you must have to read and accept the Privacy Policy & Terms of Use',
        ),
      );
      return;
    }

    // user creation model
    final signupModel = SignupModel(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    emit(SignupLoadingState());

    final result = await authRepo.signup(signupModel: signupModel);
    result.fold(
      (failure) => emit(
        SignupErrorState(failure.toString()),
      ),
      (_) => emit(const SignupSuccessState('Successfully signed up')),
    );
  }

  // Validation logic
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
