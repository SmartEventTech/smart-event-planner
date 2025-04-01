import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';



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
