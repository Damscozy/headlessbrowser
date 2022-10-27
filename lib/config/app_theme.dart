import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primaryColr = MaterialColor(
    0xFF2C42E3,
    <int, Color>{
      50: Color(0xFF2C42E3),
      100: Color(0xFF2C42E3),
      200: Color(0xFF2C42E3),
      300: Color(0xFF2C42E3),
      400: Color(0xFF2C42E3),
      500: Color(0xFF2C42E3),
      600: Color(0xFF2C42E3),
      700: Color(0xFF2C42E3),
      800: Color(0xFF2C42E3),
      900: Color(0xFF2C42E3),
    },
  );
  static const Color textColor = Color(0xFF191919);
  static const Color bgColor = Color(0xFFFFFFFF);
  static const Color btnColor = Color(0xFF2C42E3);
  static const Color cntnrColor = Color(0xFF828282);
  static const Color containerlightColor = Color(0xFFE1DEDE);
  static const Color starColor = Color(0xFFFFC300);
  static const Color tikColor = Color(0xFFFFC300);
  static const Color crossColor = Color(0xFFFFC300);
  var color = Colors.blue;

  static ThemeData themeData = ThemeData(
    primaryColor: primaryColr,
    primarySwatch: primaryColr,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppTheme.bgColor,
    fontFamily: "Nunito",
    brightness: Brightness.light,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white70,
      // border: InputBorder.none,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
