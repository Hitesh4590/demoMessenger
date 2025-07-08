import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme provider to manage light/dark mode
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Enum for custom color names
enum AppColor {
  success,
  error,
  warning,
}

// Custom colors accessor
class CustomColors {
  // Private constructor to prevent instantiation
  const CustomColors._();
  // Custom colors for light theme
  static const _lightCustomColors = {
    AppColor.success: Color(0xFF28A745), // Green for success
    AppColor.error: Color(0xFFDC3545),   // Red for error
    AppColor.warning: Color(0xFFFFC107), // Yellow for warning
  };

  // Custom colors for dark theme
  static const _darkCustomColors = {
    AppColor.success: Color(0xFF34C759), // Brighter green for dark mode
    AppColor.error: Color(0xFFFF453A),   // Brighter red for dark mode
    AppColor.warning: Color(0xFFFF9500), // Brighter yellow for dark mode
  };

  // Method to get custom color based on theme and enum
  static Color getColor(BuildContext context, AppColor color) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colors = isDarkMode ? _darkCustomColors : _lightCustomColors;
    return colors[color] ?? Colors.grey; // Fallback color if not found
  }
}

// Define light and dark themes
class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.light,
      primary: const Color(0xFFADD8E6),
      secondary: const Color(0xFF87CEEB),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color(0xFFADD8E6),
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
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.black,
      ),
    ),
  );
}