import 'package:authentication_app/core/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF24786D),
        secondary: Color(0xFF797C7B),
        surface: Colors.white,
        tertiary: Color.fromARGB(255, 81, 81, 81),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: FontFamily.circular,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF24786D),
        ),
        titleLarge: TextStyle(
          fontFamily: FontFamily.caros,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Color(0xFF000E08),
        ),
        titleMedium: TextStyle(
          fontFamily: FontFamily.circular,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF797C7B),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFC1CAD0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFC1CAD0),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF24786D),
          ),
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color(0xFFF3F6F6),
          ),
        ),
      ),

    );
  }
}
