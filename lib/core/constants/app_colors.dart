import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xff01305A);
  static const secondaryColor = Color(0xffA00651);

  static const lightScaffoldBgColor = Color(0xfff4f4f4);
  static const darkScaffoldBgColor = Color(0xff000000);

  static const hintColor = Color(0xff948D8D);
  static const bodyTextColor = Color(0xff797676);

  static const primaryTextColor = Color(0xff000000);
  static const blueTextColor = Color(0xff0E377C);

  static const shadowhiteColot = Color(0xffF9F9F9);

  static const fillColor = Color(0xffD9D9D9);
  static const grayColor = Color(0xff666464);

  static const priceColor = Color(0xff014E1D);

  static const activeIconColor = Color(0xff0E377C);
  static const inactiveIconColor = Color(0xff8C8C8C);

  static const outlinedBtnBorderColor = Color(0xffADADAD);
  static const textFieldBorderColor = Color(0xff8C8C8C);

  static const eventOpacity = Color.fromARGB(255, 39, 13, 75);

  static const textBtnColor = Color(0xFF4b68ff);

  static const sliverAppBarColor = Color.fromARGB(255, 245, 245, 245);

  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const navBarBlack = Color(0xFF232323);

  static LinearGradient interestedCardColor = LinearGradient(
    colors: [
      Color(0xff5C2FC2),
      Color(0xff819FD3),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient eventCardGradientColor = LinearGradient(
    colors: [
      Color(0xff5C2FC2).withValues(alpha: 0.32),
      Color(0xff819FD3).withValues(alpha: 0.3),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const dividerColor = Color(0xff808080);
}
