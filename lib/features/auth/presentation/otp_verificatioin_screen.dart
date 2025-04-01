import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/cubits/otp_verification_cubit/cubit/otp_verification_cubit_cubit.dart';
import 'package:smart_event_planner/core/cubits/otp_verification_cubit/cubit/otp_verification_cubit_state.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;

    return BlocProvider(
      create: (context) => OtpVerificationCubit(
        authRepo: context.read(),
        email: email,
      ),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
              listener: (context, state) {
                if (state is OtpVerificationSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Account verified successfully'),
                    ),
                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.hobbyScreen, (route) => false);
                } else if (state is OtpVerificationFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 80,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enter the OTP sent to\n$email',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Pinput(
                        
                        length: 4,
                        controller: pinController,
                        focusNode: focusNode,
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.transparent),
                          ),
                        ),
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                        onCompleted: (pin) {
                          if (formKey.currentState!.validate()) {
                            context.read<OtpVerificationCubit>().verifyOtp(pin);
                          }
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                        ),
                        errorPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            focusNode.unfocus();
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<OtpVerificationCubit>()
                                  .verifyOtp(pinController.text);
                            }
                          },
                          child: state is OtpVerificationLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Verify',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
