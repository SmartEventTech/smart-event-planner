import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/cubits/otp_verification_cubit/cubit/otp_verification_cubit_cubit.dart';
import 'package:smart_event_planner/core/cubits/otp_verification_cubit/cubit/otp_verification_cubit_state.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});
  static const String id = 'otp-verification-screen';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  // Styling for the OTP input fields
  final defaultPinTheme = PinTheme(
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
  );

  // Colors
  final focusedBorderColor = AppColors.primaryColor;
  final fillColor = Colors.grey.shade100;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationCubit(
        authRepo: context.read(),
        email: widget.email,
      ),
      child: Scaffold(
        body: BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
          listener: (context, state) {
            if (state is OtpVerificationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text('Account verified successfully'),
              ));
              Navigator.pushNamedAndRemoveUntil(context, Routes.hobbyScreen , (route) => false);
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
            return Padding(
              padding: const EdgeInsets.only(top: 250, left:55 , ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Enter the OTP sent to\n ${widget.email}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 4,
                        controller: pinController,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                          if (formKey.currentState!.validate()) {
                            context.read<OtpVerificationCubit>().verifyOtp(pin);
                          }
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Removed Resend OTP button since API doesn't support it
                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            focusNode.unfocus();
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<OtpVerificationCubit>()
                                  .verifyOtp(pinController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: state is OtpVerificationLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'Verify',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
