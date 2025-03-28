import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/cubits/signup_cubit/signup_cubit.dart';
import 'package:smart_event_planner/core/cubits/signup_cubit/signup_state.dart';
import 'package:smart_event_planner/core/success_dialog/success_dialog.dart';
import 'package:smart_event_planner/core/widgets/custom_text_field.dart';
import 'package:smart_event_planner/core/widgets/error_bar.dart';
import 'package:smart_event_planner/features/authentication/otp_werificatioin_screen.dart';

import 'package:smart_event_planner/features/authentication/widgets/privacy_plicy_check_box.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool termsAccepted = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return BlocListener<SignupCubit, SignupState>(
    listener: (context, state) {
      if (state is SignupFailure) {
        buildErrorBar(context, state.message);
      } else if (state is SignupSuccess) {
        showSuccessDialog(
          context: context,
          title: 'Account Created Successfully',
          message: 'An Email has been sent to \n${state.userEntity.email}\n\nPlease verify your account',
          buttonText: 'Continue',
          onPressed: () {
            // Navigate to OTP verification screen with the user's email
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                  email: state.userEntity.email,
                  
                ),
              ),
            );
          },
        );
      }
    },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: autoValidateMode,
            key: formKey,
            child: Column(
              children: [
                Image.asset('assets/logos/appLogo.png', width: 140),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: nameController,
                  label: 'Name',
                  hint: 'Enter your name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: emailController,
                  label: 'E-mail',
                  hint: 'Enter your email',
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
                  controller: passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
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
                PrivacypolicyCheckBox(
                  onTermsAccepted: (value) {
                    setState(() {
                      termsAccepted = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return buildSignupButton(
                      context,
                      isLoading: state is SignupLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (termsAccepted) {
                            context
                                .read<SignupCubit>()
                                .createUserWithEmailAndPassword(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          } else {
                            buildErrorBar(
                                context, 'Please accept the privacy policy');
                          }
                        } else {
                          setState(() {
                            autoValidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 40),
                buildLoginText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignupButton(BuildContext context,
      {required bool isLoading, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(15, 55, 124, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(double.infinity, 55),
      ),
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Sign Up',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
    );
  }

  Widget buildLoginText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 8)),
        InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.loginScreen),
          child: const Text(' Login',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 10)),
        ),
      ],
    );
  }
}
