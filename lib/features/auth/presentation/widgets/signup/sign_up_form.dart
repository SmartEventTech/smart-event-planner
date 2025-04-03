import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/core/widgets/popups/full_screen_loader.dart';
import 'package:smart_event_planner/core/widgets/popups/loaders.dart';
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
                _nameField(context),
                const SizedBox(height: AppSizes.spaceBtwTextField),
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

  TextFormField _nameField(BuildContext context) {
    return TextFormField(
      controller: context.read<SignupCubit>().nameController,
      validator: (value) => TValidator.validateEmptyText('Name', value),
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      decoration: const InputDecoration(
        labelText: 'Username',
        prefixIcon: Icon(Iconsax.direct),
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
          if (state is PrivacyValidationErrorState) {
            Loaders.warningSnackBar(
              title: 'Accept Privacy Policy',
              message: state.errorMessage,
            );
          } else if (state is PasswordValidationErrorState) {
            Loaders.warningSnackBar(
              title: 'wrong password',
              message: state.errorMessage,
            );
          } else if (state is SignupLoadingState) {
            TFullScreenLoader.openLoadingDialog(
              'We are processing your information...',
              AppImages.docerAnimation,
            );
          } else if (state is SignupErrorState) {
            TFullScreenLoader.stopLoading();
            Loaders.errorSnackBar(
              title: 'Error',
              message: state.message,
            );
          } else if (state is SignupSuccessState) {
            TFullScreenLoader.stopLoading();
            _navigateToVerifyEmail(
              context,
              context.read<SignupCubit>().emailController.text.trim(),
            );
            Loaders.successSnackBar(
              title: 'Verify your email',
              message: 'Please check your email to verify your account',
            );
          }
        },
        child: Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () {
              var isPrivacyAccepted = context
                  .read<PasswordAndSelectionCubit>()
                  .state
                  .isPrivacyAccepted;
              context.read<SignupCubit>().signup(isPrivacyAccepted);
            },
            child: const Text('Create Account'),
          );
        }),
      ),
    );
  }

  void _navigateToVerifyEmail(BuildContext context, email) {
    context.pushNamedAndRemoveUntilPage(Routes.otpVerificationScreen,
        arguments: email);
  }
}
