import 'package:flutter/material.dart';
import 'package:smart_event_planner/config/routing/routes.dart';

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






Widget buildSignupButton(BuildContext context ,{required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(15, 55, 124, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minimumSize: const Size(double.infinity, 55),
    ),
    onPressed:onPressed,
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
