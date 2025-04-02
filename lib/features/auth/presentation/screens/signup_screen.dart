import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/config/service_locator.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:smart_event_planner/features/auth/presentation/widgets/form_divider.dart';
import 'package:smart_event_planner/features/auth/presentation/widgets/signup/sign_up_form.dart';
import 'package:smart_event_planner/features/auth/presentation/widgets/social_buttons.dart';
import 'package:smart_event_planner/shared/widgets/auth/auth_header.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SignupCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header // Image
              AuthHeader(),
              // Logo
              Image.asset(AppImages.appLogo, width: 140),
              const SizedBox(height: 40),
              // Login Form
              SignupForm(),
              SizedBox(height: AppSizes.spaceBtwSections),
              // Divider
              TFormDivider(dividerText: 'or Sign in with'),
              SizedBox(height: 32.0),
              // Social Buttons
              TSocialButtons(),
              SizedBox(height: 32.0),
              // Footer
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Navigator.pushNamed(context, Routes.loginScreen),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: kToolbarHeight,
              )
            ],
          ),
        ),
      ),
    );
  }
}
