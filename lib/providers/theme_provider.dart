import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme provider to manage light/dark mode
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Define light and dark themes
class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      // seedColor: const Color(0xFFADD8E6),
      seedColor:  Colors.white,
      // Light blue from image background
      brightness: Brightness.light,
      primary: const Color(0xFFADD8E6),
      secondary: const Color(0xFF87CEEB),
      // Lighter blue accent
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color(0xFFADD8E6),
    // Match image background
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFADD8E6),
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF87CEEB),
        foregroundColor: Colors.black,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFADD8E6),
      brightness: Brightness.dark,
      primary: const Color(0xFF87CEEB),
      secondary: const Color(0xFF63B8FF),
      surface: const Color(0xFF1A2E44),
      // Darker surface for contrast
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
    ),
    scaffoldBackgroundColor: const Color(0xFF1A2E44),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A2E44),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white70,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.white54, fontSize: 14),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF87CEEB),
        foregroundColor: Colors.black,
      ),
    ),
  );
}
