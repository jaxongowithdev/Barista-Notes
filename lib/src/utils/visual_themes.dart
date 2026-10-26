import 'package:flutter/material.dart';

class VisualThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6F4E37), // Coffee brown
        brightness: Brightness.light,
        primary: const Color(0xFF6F4E37), // Rich coffee brown
        secondary: const Color(0xFFD4A574), // Latte color
        tertiary: const Color(0xFF8B4513), // Saddle brown
        surface: const Color(0xFFFAF8F6), // Cream
      ),
      scaffoldBackgroundColor: const Color(0xFFFAF8F6),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF6F4E37),
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD4A574)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD4A574)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF6F4E37), width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFD4A574).withOpacity(0.3),
        selectedColor: const Color(0xFF6F4E37),
        labelStyle: const TextStyle(color: Color(0xFF6F4E37)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6F4E37),
        brightness: Brightness.dark,
        primary: const Color(0xFFD4A574), // Lighter for dark mode
        secondary: const Color(0xFF8B4513),
        tertiary: const Color(0xFFA67C52),
        surface: const Color(0xFF1C1410), // Dark coffee
      ),
      scaffoldBackgroundColor: const Color(0xFF1C1410),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF2D2419),
        foregroundColor: Color(0xFFD4A574),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF2D2419),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2D2419),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF8B4513)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF8B4513)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD4A574), width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF8B4513).withOpacity(0.3),
        selectedColor: const Color(0xFFD4A574),
        labelStyle: const TextStyle(color: Color(0xFFD4A574)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // Coffee-themed color palette
  static const Color espresso = Color(0xFF3E2723);
  static const Color americano = Color(0xFF5D4037);
  static const Color latte = Color(0xFFD4A574);
  static const Color cappuccino = Color(0xFFA67C52);
  static const Color cream = Color(0xFFFAF8F6);
  static const Color darkRoast = Color(0xFF1C1410);
  static const Color mediumRoast = Color(0xFF6F4E37);
  static const Color lightRoast = Color(0xFF8B7355);

  // Difficulty colors
  static const Color beginnerGreen = Color(0xFF4CAF50);
  static const Color intermediateOrange = Color(0xFFFF9800);
  static const Color advancedRed = Color(0xFFF44336);

  // Category colors
  static const Color manualBlue = Color(0xFF2196F3);
  static const Color pressureRed = Color(0xFFE91E63);
  static const Color immersionPurple = Color(0xFF9C27B0);

  static Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
      case 'easy':
        return beginnerGreen;
      case 'intermediate':
      case 'medium':
        return intermediateOrange;
      case 'advanced':
      case 'hard':
        return advancedRed;
      default:
        return mediumRoast;
    }
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'manual':
        return manualBlue;
      case 'pressure':
        return pressureRed;
      case 'immersion':
        return immersionPurple;
      default:
        return mediumRoast;
    }
  }

  static LinearGradient get coffeeGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF6F4E37),
          Color(0xFF8B4513),
          Color(0xFFD4A574),
        ],
      );

  static LinearGradient get creamGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFAF8F6),
          Color(0xFFF5F0EA),
        ],
      );
}
