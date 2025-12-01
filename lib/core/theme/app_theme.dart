import 'package:flutter/material.dart';

class AppTheme {
  // Define colors for light theme
  static const Color _lightPrimaryColor = Colors.blue;
  static const Color _lightPrimaryVariantColor = Colors.blueAccent;
  static const Color _lightOnPrimaryColor = Colors.white;
  static const Color _lightTextColor = Colors.black;
  static const Color _lightBackgroundColor = Color.fromARGB(230, 255, 255, 255);
  static const Color _lightTertiaryColor = Colors.blueGrey;

  // Define colors for dark theme
  static const Color _darkPrimaryColor = Colors.blueGrey;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkTextColor = Colors.white;
  static const Color _darkBackgroundColor = Color(0xFF121212);
  static const Color _darkTertiaryColor = Colors.blueGrey;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      secondary: _lightPrimaryVariantColor,
      surface: _lightBackgroundColor,
      onSurface: _lightTextColor,
      tertiary: _lightTertiaryColor,
      onTertiary: _lightOnPrimaryColor,
    ),
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightBackgroundColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      titleTextStyle: TextStyle(
        color: _lightOnPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: _lightTextColor),
      bodyMedium: TextStyle(color: _lightTextColor),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _lightPrimaryColor,
      contentTextStyle: TextStyle(color: _lightOnPrimaryColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      onPrimary: _darkOnPrimaryColor,
      secondary: _darkPrimaryVariantColor,
      surface: _darkPrimaryVariantColor,
      onSurface: _darkTextColor,
      tertiary: _darkTertiaryColor,
      onTertiary: _darkOnPrimaryColor,
    ),
    scaffoldBackgroundColor: _darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkPrimaryColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      titleTextStyle: TextStyle(
        color: _darkOnPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: _darkTextColor),
      bodyMedium: TextStyle(color: _darkTextColor),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _darkPrimaryColor,
      contentTextStyle: TextStyle(color: _darkOnPrimaryColor),
    ),
  );
}
