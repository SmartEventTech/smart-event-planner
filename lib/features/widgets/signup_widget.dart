import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';
import 'package:smart_event_planner/features/widgets/login_widget.dart';

Widget buildSignupBackground() {
  return Stack(
    children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Image.asset(
          'assets/images/signUp.png',
          fit: BoxFit.fill,
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Image.asset(
          'assets/images/signUpOpacity.png',
          fit: BoxFit.fill,
        ),
      ),
    ],
  );
}

Widget buildSignupForm(BuildContext context) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      height: MediaQuery.of(context).size.height * 0.79,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/logos/appLogo.png', width: 140),
              const SizedBox(height: 40),
              buildTextField(label: 'E-mail', hint: 'Enter your email'),
              const SizedBox(height: 15),
              buildTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  isPassword: true),
              const SizedBox(height: 15),
              buildTextField(
                  label: 'Password Confirmation',
                  hint: 'Confirm your password',
                  isPassword: true),
              const SizedBox(height: 15),
              buildPrivacyPolicyCheckbox(),
              const SizedBox(height: 25),
              buildSignupButton(context),
              const SizedBox(height: 25),
              buildDividerWithText(),
              const SizedBox(height: 30),
              buildSocialLogin(),
              const SizedBox(height: 40),
              buildLoginText(context),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildPrivacyPolicyCheckbox() {
  return Row(
    children: [
      Checkbox(value: false, onChanged: (value) {}),
      const Text(
        'I agree to the privacy policy',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 10),
      ),
    ],
  );
}

Widget buildSignupButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(15, 55, 124, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minimumSize: const Size(double.infinity, 55),
    ),
    onPressed: () {
      Navigator.pushNamed(context, Routes.hobbyScreen);
    },
    child: const Text(
      'Sign Up',
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

Widget buildLoginText(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Already have an account?',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 8)),
      InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.loginScreen),
        child: const Text(' Login',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 10)),
      ),
    ],
  );
}
