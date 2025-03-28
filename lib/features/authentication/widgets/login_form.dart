

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/config/routing/routes.dart';

import 'package:smart_event_planner/core/cubits/signin_cubit/signin_cubit.dart';
import 'package:smart_event_planner/core/cubits/signin_cubit/signin_state.dart';
import 'package:smart_event_planner/core/widgets/custom_text_field.dart';
import 'package:smart_event_planner/core/widgets/error_bar.dart';
import 'package:smart_event_planner/features/widgets/login_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignInCubit>().formKey,
      child: Column(
        children: [
          Image.asset('assets/logos/appLogo.png', width: 140),
          const SizedBox(height: 40),
          CustomTextField(
            label: 'Email',
            hint: 'Enter your email',
            controller: context.read<SignInCubit>().emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: context.read<SignInCubit>().passwordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          // _buildLoginButton(context),
          BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state is SignInFailure) {
                buildErrorBar(context, state.message);
              } else if (state is SignInSuccess) {
                Future.delayed(const Duration(milliseconds: 200 )).then((value) {
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.navigationScreen, (route) => false);
                  }
                });
              }
            },
            builder: (context, state) {
              return _buildLoginButton(
                context,
                state: state,
                onPressed: () async {
                  await context
                      .read<SignInCubit>()
                      .signInWithEmailAndPassword();
                },
              );
            },
          ),
          const SizedBox(height: 25),
          buildDividerWithText(),
          const SizedBox(height: 30),
          buildSocialLogin(),
          const SizedBox(height: 40),
          buildSignupText(context),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context,
      {required VoidCallback onPressed, required SignInState state}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(15, 55, 124, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(double.infinity, 55),
      ),
      onPressed: state is SignInSuccess ? null : onPressed,
      child: state is SignInLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : state is SignInSuccess
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                )
              : Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
    );
  }
}
