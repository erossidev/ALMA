import 'package:flutter/material.dart';

class AlmaTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        scaffoldBackgroundColor: const Color(0xFF0B132B),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00D5FF),
          brightness: Brightness.dark,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B132B),
          elevation: 0,
          centerTitle: true,
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

          headlineMedium: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),

          bodyLarge: TextStyle(
            fontSize: 20,
            color: Color(0xFF00D5FF),
          ),
        ),
      );
}