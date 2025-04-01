import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signup_cubit/signup_state.dart';
import 'package:smart_event_planner/core/utils/validators/validation.dart';
import 'package:smart_event_planner/features/auth/presentation/widgets/password_field.dart';
import 'package:smart_event_planner/features/auth/presentation/widgets/term_and_condation_checkbox.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordAndSelectionCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
        ),
        child: AutofillGroup(
          child: Form(
            key: context.read<SignupCubit>().formKey,
            child: Column(
              children: [
                _emailField(context),
                const SizedBox(height: AppSizes.spaceBtwTextField),
                PasswordField(
                  controller: context.read<SignupCubit>().passwordController,
                ),
                const SizedBox(height: AppSizes.spaceBtwTextField),
                PasswordField(
                  passwordField: false,
                  labelText: 'Confirm Password',
                  controller:
                      context.read<SignupCubit>().confirmPasswordController,
                ),
                const SizedBox(height: 32.0),
                const TTermAndCondationCheckbox(),
                const SizedBox(height: 32.0),
                _createAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _emailField(BuildContext context) {
    return TextFormField(
      controller: context.read<SignupCubit>().emailController,
      validator: (value) => TValidator.validateEmail(value),
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      decoration: const InputDecoration(
        labelText: 'E-Mail',
        prefixIcon: Icon(Iconsax.direct),
      ),
    );
  }

  SizedBox _createAccount(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          // if (state is PrivacyValidationErrorState) {
          //   Loaders.warningSnackBar(
          //     title: 'Accept Privacy Policy',
          //     message: state.errorMessage,
          //   );
          // } else if (state is SignupLoadingState) {
          //   TFullScreenLoader.openLoadingDialog(
          //     'We are processing your information...',
          //     TImages.docerAnimation,
          //   );
          // } else if (state is SignupErrorState) {
          //   TFullScreenLoader.stopLoading();
          //   Loaders.errorSnackBar(
          //     title: 'Error',
          //     message: state.errorMessage,
          //   );
          // } else if (state is SignupSuccessState) {
          //   TFullScreenLoader.stopLoading();
          //   _navigateToVerifyEmail(
          //     context,
          //     context.read<SignupCubit>().emailController.text.trim(),
          //   );
          //   Loaders.successSnackBar(
          //     title: 'Congratulations',
          //     message: state.message,
          //   );
          // }
        },
        child: Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () {
              var isPrivacyAccepted = context
                  .read<PasswordAndSelectionCubit>()
                  .state
                  .isPrivacyAccepted;
              //  context.read<SignupCubit>().signup(isPrivacyAccepted);
            },
            child: const Text('Create Account'),
          );
        }),
      ),
    );
  }

  // void _navigateToVerifyEmail(BuildContext context, email) {
  //   context.removeAll(
  //     VerifyEmailPage(email: email),
  //   );
  // }
}
