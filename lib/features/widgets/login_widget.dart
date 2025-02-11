import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';

Widget buildLoginBackground() {
  return Stack(
    children: [
      Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Image.asset(
          'assets/images/login.png',
          fit: BoxFit.fill,
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Image.asset(
          'assets/images/OpacityLogin.png',
          fit: BoxFit.fill,
        ),
      ),
    ],
  );
}

Widget buildLoginForm(BuildContext context) {
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
              buildLoginButton(context),
              const SizedBox(height: 25),
              buildDividerWithText(),
              const SizedBox(height: 30),
              buildSocialLogin(),
              const SizedBox(height: 40),
              buildSignupText(context),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildTextField(
    {required String label, required String hint, bool isPassword = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(label,
            style: const TextStyle(
              fontSize: 12,
                fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      const SizedBox(height: 5),
      TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    ],
  );
}

Widget buildLoginButton(BuildContext context) {
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
      'Login',
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

Widget buildDividerWithText() {
  return Row(
    children: [
      const Expanded(child: Divider(color: Colors.black, thickness: 1)),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text("Or login with",
            style: TextStyle(fontSize: 12, color: Colors.black)),
      ),
      const Expanded(child: Divider(color: Colors.black, thickness: 1)),
    ],
  );
}

Widget buildSocialLogin() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        child: Image.asset('assets/icons/googleIcon.png', width: 50),
      ),
      const SizedBox(width: 30),
      InkWell(
        child: Image.asset('assets/icons/faceIcon.png', width: 50),
      ),
    ],
  );
}

Widget buildSignupText(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have an account?",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 8),
      ),
      InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.signupScreen),
        child: const Text(
          ' Sign Up',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),
        ),
      ),
    ],
  );
}
