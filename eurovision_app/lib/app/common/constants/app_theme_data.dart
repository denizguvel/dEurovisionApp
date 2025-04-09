import 'package:flutter/material.dart';

class AppThemeData {
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
        textStyle: textTheme.bodyMedium,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.black,
    textTheme: textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        textStyle: textTheme.bodyMedium,
      ),
    ),
  );
}
