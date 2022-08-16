import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color darkScaffoldBackground = Color(0xFF060E1E);
  static const Color green = Color(0xFF61E757);
  static const Color red = Color(0xFFEC4B4B);

  static final ThemeData lightTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 36),
        unselectedIconTheme: IconThemeData(size: 36),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonTheme:
      const FloatingActionButtonThemeData(iconSize: 36),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: lightPrimary),
          bodySmall: TextStyle(fontSize:14, color:Colors.black)
      ),
  );
  static final ThemeData darkTheme = ThemeData(
      primaryColor: darkScaffoldBackground,
      scaffoldBackgroundColor: darkScaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 36),
        unselectedIconTheme: IconThemeData(size: 36),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonTheme:
      const FloatingActionButtonThemeData(iconSize: 36),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: lightPrimary),
          bodySmall: TextStyle(fontSize:14, color:Colors.white)
      ),
  );
}
