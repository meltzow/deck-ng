import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Color(0xff3a57e8),
      scaffoldBackgroundColor: Color(0xffffffff),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 22,
          color: Color(0xff000000),
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          color: Color(0xffa29b9b),
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xff000000),
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xff7c7878),
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xff5ee462),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Color(0xff000000), width: 1),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xff929392),
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Color(0xff000000),
        ),
        filled: true,
        fillColor: Color(0x00ffffff),
        isDense: false,
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }
}
