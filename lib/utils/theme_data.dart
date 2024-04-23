import 'package:flutter/material.dart';

// ignore_for_file: deprecated_member_use
class AppTheme {
  // Colors
  //static const Color primaryColor = Color(0xFF3D3D3D);
  static const Color primaryColor = Color(0xFF1C1C1E);
  static const Color secondaryColor = Color(0xFF95A5A6);
  static const Color backgroundColor = Color(0xFFF7F7F7);
  static const Color inputColor = Color(0xFFD9D9D9);
  static const Color textColor = Color(0xFF1F1F1F);

  // Text Styles
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );
  static const TextStyle elementTitle =
      TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w600);
  static const TextStyle categoryText =
      TextStyle(fontSize: 10, color: textColor, fontWeight: FontWeight.w500);
  static const TextStyle smallText =
      TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.w500);
  static BoxShadow globalShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 0.5,
    blurRadius: 1,
    offset: Offset(0, 0.5), // changes position of shadow
  );
}

final ThemeData appThemeData = ThemeData(
  primaryColor: AppTheme.primaryColor,
  hintColor: AppTheme.secondaryColor,
  scaffoldBackgroundColor: AppTheme.backgroundColor,
  textTheme: const TextTheme(
      headline1: AppTheme.headingTextStyle, bodyText1: AppTheme.bodyTextStyle),
);
