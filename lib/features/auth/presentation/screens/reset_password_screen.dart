import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/text_strings.dart';
import 'package:smart_event_planner/core/cubits/password_and_selection/password_and_selection_cubit.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:smart_event_planner/core/utils/validators/validation.dart';
import 'package:smart_event_planner/core/widgets/popups/full_screen_loader.dart';
import 'package:smart_event_planner/core/widgets/popups/loaders.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/forget_password/reset_password_cubit.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/forget_password/reset_password_state.dart';
import 'package:smart_event_planner/features/auth/presentation/widgets/password_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;
    context.read<ResetPasswordCubit>().emailController.text = email;
    return BlocProvider(
      create: (context) => PasswordAndSelectionCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultScreenPadding),
            child: Form(
              key: context.read<ResetPasswordCubit>().formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Text(
                    'Please enter your new password for\n$email', 
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  // _emailField(context),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  PasswordField(
                    controller:
                        context.read<ResetPasswordCubit>().passwordController,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  PasswordField(
                    passwordField: false,
                    labelText: 'Confirm Password',
                    controller: context
                        .read<ResetPasswordCubit>()
                        .confPasswordController,
                  ),
                  const SizedBox(height: 32.0),
                  _submitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: context.read<ResetPasswordCubit>().emailController,
      validator: (value) => TValidator.validateEmail(value),
      decoration: const InputDecoration(
        labelText: TTexts.email,
        prefixIcon: Icon(Iconsax.direct_right),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          TFullScreenLoader.openLoadingDialog(
            'Logging you in...',
            AppImages.docerAnimation,
          );
        } else if (state is ResetPasswordSuccessState) {
          TFullScreenLoader.stopLoading();
          Loaders.successSnackBar(
              title: 'Success', message: state.successMessage);
          context.pushNamedAndRemoveUntilPage(Routes.loginScreen);
        } else if (state is ResetPasswordErrorState) {
          TFullScreenLoader.stopLoading();
          Loaders.errorSnackBar(title: 'Error', message: state.errorMessage);
        } else if (state is ResetPasswordValidationErrorState) {
          Loaders.warningSnackBar(
              title: 'Wrong Password', message: state.errorMessage);
        }
      },
      builder: (context, state) => state is CheckEmailLoadingState
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<ResetPasswordCubit>().resetPassword();
                },
                child: const Text(TTexts.submit),
              ),
            ),
    );
  }
}
