import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo authRepo;

  SignupCubit({required this.authRepo}) : super(SignupInitial());

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Future<void> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required String name,
  // }) async {
  //   emit(SignupLoading());
  //   try {
  //     final result = await authRepo.signup(
  //       signupModel: SignupModel(
  //         email,
  //         password,
  //         name,
  //       ),
  //     );

  //     result.fold(
  //       (failure) =>
  //           emit(SignupFailure(message: _mapFailureToMessage(failure))),
  //       (userEntity) => emit(SignupSuccess(userEntity: userEntity)),
  //     );
  //   } catch (e) {
  //     emit(SignupFailure(message: _mapExceptionToMessage(e)));
  //   }
  // }

  // String _mapFailureToMessage(Failure failure) {
  //   if (failure is ServerFailure) {
  //     return failure.message;
  //   } else if (failure is NetworkFailure) {
  //     return 'Network error: ${failure.message}';
  //   }
  //   return 'An unexpected error occurred';
  // }

  // String _mapExceptionToMessage(dynamic e) {
  //   if (e is SocketException) {
  //     return 'Network error: Please check your internet connection';
  //   } else if (e is TimeoutException) {
  //     return 'Request timeout: Server took too long to respond';
  //   }
  //   return 'An unexpected error occurred';
  // }
}
