import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {

  void pushPage(String routeName) => Navigator.pushNamed(this, routeName);
  void pushPageAndRemoveAll(String routeName) => Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false);
  
  void pushReplacement(Widget screen) => Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => screen));
  void pushAndRemoveAll(Widget screen) => Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (context) => screen), (route) => false); // fasle => mean remove all another screens

  void pop() => Navigator.pop(this);
}