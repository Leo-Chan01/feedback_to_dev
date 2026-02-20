
import 'package:flutter/material.dart';

extension ColorTextStyle on TextStyle {
  TextStyle get yfdBlack01 => copyWith(color: AppColors.yfdGrey06);
  TextStyle get yfdPrimaryDark =>
      copyWith(color: AppColors.yfdPrimaryDark);
  TextStyle get yfdPrimary => copyWith(color: AppColors.yfdPrimary);
  TextStyle get yfdSecondaryLight =>
      copyWith(color: AppColors.yfdSecondaryLight);
  TextStyle get yfdMainBlack =>
      copyWith(color: AppColors.yfdMainBlack);
  TextStyle get yfdWhite => copyWith(color: AppColors.yfdWhite);
  TextStyle get yfdBlack02 => copyWith(color: AppColors.yfdGrey03);
  TextStyle get yfdBlack04 => copyWith(color: AppColors.yfdGrey04);
  TextStyle get yfdBlack05 => copyWith(color: AppColors.yfdGrey05);
  TextStyle get yfdRed03 => copyWith(color: AppColors.yfdRed03);
  TextStyle get yfdBlue03 => copyWith(color: AppColors.yfdBlue03);
  TextStyle get yfdBlue02 => copyWith(color: AppColors.yfdBlue02);
  TextStyle get yfdBlue01 => copyWith(color: AppColors.yfdBlue01);
  TextStyle get yfdBlueBottomNavSelectedItem =>
      copyWith(color: AppColors.yfdBlueBottomNavSelectedItem);
  TextStyle get yfdPrimaryBlue =>
      copyWith(color: AppColors.yfdPrimaryBlue);
  TextStyle get yfdBlue04 => copyWith(color: AppColors.yfdBlue04);
  TextStyle get yfdBlue04RGB =>
      copyWith(color: AppColors.yfdBlue04RGB);
  TextStyle get yfdRed01 => copyWith(color: AppColors.yfdRed01);
  TextStyle get yfdRedFill => copyWith(color: AppColors.yfdRedFill);
  TextStyle get yfdRed02 => copyWith(color: AppColors.yfdRed02);
  TextStyle get yfdRed04 => copyWith(color: AppColors.yfdRed04);
  TextStyle get yfdRed05 => copyWith(color: AppColors.yfdRed05);
  TextStyle get yfdRed005 => copyWith(color: AppColors.yfdRed005);
  TextStyle get yfdRedPure => copyWith(color: AppColors.yfdRedPure);
  TextStyle get yfdRedTransparent =>
      copyWith(color: AppColors.yfdRedTransparent);
  TextStyle get yfdDarkBlue => copyWith(color: AppColors.yfdDarkBlue);
  TextStyle get yfdLightBlue =>
      copyWith(color: AppColors.yfdLightBlue);
  TextStyle get yfdButtonBlue =>
      copyWith(color: AppColors.yfdButtonBlue);
  TextStyle get yfdGreenPure =>
      copyWith(color: AppColors.yfdGreenPure);
  TextStyle get yfdDiabledColor =>
      copyWith(color: AppColors.yfdDiabledColor);
}

class AppColors {
  AppColors._();

  //MAIN THEMES
  static Color yfdPrimaryDark = const Color(0xFF1A73E8);
  static Color yfdPrimary = const Color(0xFF1A73E8);
  static Color yfdSecondaryDark = const Color(0xFF1E1E1E);
  static Color yfdSecondaryLight = const Color(0xFF1A73E8);
  static LinearGradient yfdPrimaryGradient = LinearGradient(
    colors: [AppColors.yfdGrey03, AppColors.yfdGrey05],
  );

  //GREY
  static Color yfdMainBlack = Colors.black;
  static Color yfdWhite = const Color(0xFFFFFFFF);
  static Color yfdGrey06 = const Color(0xFF1E1E1E);
  static Color yfdGrey07 = const Color(0xFF1C1C1E);
  static Color yfdGrey05 = const Color(0xFF333333);
  static Color yfdGrey04 = const Color(0x337C8694);
  static Color yfdBackgrundColor = const Color(0XFF1D2027);
  static Color yfdGrey04RGB = const Color.fromRGBO(209, 227, 250, 0.2);
  static Color yfdGrey03 = const Color(0x33D1E3FA);
  static Color yfdGrey03RGB = const Color.fromRGBO(124, 134, 148, 0.2);
  static Color yfdDarkGrey03 = const Color(0xFF8E8E8E);
  static Color yfdDarkGrey05 = const Color(0xFF434343);
  static Color yfdLightGrey06 = const Color(0xFFF5F5F5);
  static Color yfdLightGrey07 = const Color(0xFFCCCCCC);
  static Color yfdLightGrey08 = const Color(0xFFA3A3A3);
  static Color yfdLightGrey09 = const Color(0xFF7A7A7A);
  static Color yfdLightGrey10 = const Color(0xFF525252);
  static Color yfdLightGrey11 = const Color(0xFF313131);
  static Color yfdGreyTransparent20Perc = const Color(0x337C8694);
  static Color yfdGrey10PercentTransparent = const Color(0x1AF5F5F5);

  //BLUES
  static Color yfdBlue03 = const Color(0xFF9EBBF1);
  static Color yfdBlue02 = const Color(0xFF638FEA);
  static Color yfdBlue01 = const Color(0xFF3E64C0);
  static Color yfdBlueBottomNavSelectedItem = const Color(0xFF4B79E7);
  static Color yfdPrimaryBlue = const Color(0xFF4B79E7);
  static Color yfdBlue04 = const Color(0xD8E4F9FF);
  static Color yfdBlue04RGB = const Color.fromRGBO(216, 228, 249, 1);
  static Color yfdDarkBlue = const Color(0xFF1F2E43);
  static Color yfdLightBlue = const Color(0xFFF6FAFF);
  static Color yfdButtonBlue = const Color(0xFF4092F8);
  static Color yfdBlue10Percent = const Color(0x1A8CB9F3);
  static Color yfdBlue50Percent = const Color(0x5A8CB9F3);

  //REDS
  static Color yfdRed01 = const Color(0xFF973A30);
  static Color yfdRedFill = const Color.fromRGBO(245, 237, 237, 0.5);
  static Color yfdRed02 = const Color(0xFFA5554F);
  static Color yfdRed05 = const Color(0x66F0D3D3);
  static Color yfdRed03 = const Color(0xFFD89090);
  static Color yfdRed04 = const Color(0xFFE7D5D4);
  static Color yfdRed005 = const Color(0xFFF5EDED);
  static Color yfdRedPure = const Color(0xFFE64040);
  static Color yfdRedTransparent = const Color.fromRGBO(
    245,
    237,
    237,
    0.5,
  );

  //GREEN
  static Color yfdGreenPure = const Color(0xFF00D471);
  static Color yfdDiabledColor = const Color.fromARGB(255, 163, 163, 163);

  static Map<Color, Color> get contrast {
    return {
      orange: blue,
      white: black,
      black: white,
      grey: darkGrey,
    };
  }

  static Color contrastColor(Color color) {
    assert(
      contrast.containsKey(color),
      'You have not provided any dark theme',
    );
    return contrast[color]!;
  }

  static Color orange = const Color(0xFFFC7100);
  static Color blue = const Color(0xFF13A9F4);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color grey = const Color(0xFF707070);
  static Color darkGrey = const Color(0xFF707070);
  static Color darkGrey01 = const Color(0xFFD2D2D2);
  static Color darkGrey02 = const Color(0xFFB4B4B4);
}
