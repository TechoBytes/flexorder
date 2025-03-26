import 'package:flutter/material.dart';

class AppTheme {
  // Main Colors
  static const Color primaryColor = Color(0xFF0F3B69); // Deep blue
  static const Color secondaryColor = Color(0xFF1B5694); // Slightly lighter blue
  static const Color accentColor = Color(0xFF2980B9); // Accent blue
  static const Color backgroundColor = Color(0xFF0F3B69); // Dark blue background
  static const Color surfaceColor = Color(0xFF0F3B69); 
  static const Color errorColor = Color(0xFFE74C3C); // Error red
  static const Color successColor = Color(0xFF2ECC71); // Success green
  static const Color warningColor = Color(0xFFF39C12); // Warning orange
  static const Color textColor = Colors.white; // Text on dark background
  static const Color textDarkColor = Color(0xFF333333); // Text on light background
  static const Color textLightColor = Color(0xFFCCCCCC); // Subtle text
  static const Color bottomNavBarColor = Color(0xFF0A2D52); // Darker blue for nav bar
  
  // Background decoration for pages
  static BoxDecoration get backgroundDecoration {
    return const BoxDecoration(
      color: primaryColor,
    );
  }

  // Method to create a semi-transparent container for content
  static BoxDecoration get contentBoxDecoration {
    return BoxDecoration(
      color: secondaryColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
    );
  }

  // Card decoration
  static BoxDecoration get cardDecoration {
    return BoxDecoration(
      color: secondaryColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
    );
  }

  // Button styles
  static ButtonStyle get primaryButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  static ButtonStyle get secondaryButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  static ButtonStyle get outlineButtonStyle {
    return OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  // Input decoration
  static InputDecoration get inputDecoration => InputDecoration(
    fillColor: Colors.white.withOpacity(0.1),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.1),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: accentColor,
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    labelStyle: const TextStyle(
      color: Colors.white70,
    ),
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.5),
    ),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlineButtonStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColor),
        ),
      ),
      cardTheme: CardTheme(
        color: secondaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: textColor),
        displayMedium: TextStyle(color: textColor),
        displaySmall: TextStyle(color: textColor),
        headlineLarge: TextStyle(color: textColor),
        headlineMedium: TextStyle(color: textColor),
        headlineSmall: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor),
        titleMedium: TextStyle(color: textColor),
        titleSmall: TextStyle(color: textColor),
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textLightColor),
        labelLarge: TextStyle(color: textColor),
        labelMedium: TextStyle(color: textColor),
        labelSmall: TextStyle(color: textLightColor),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bottomNavBarColor,
        selectedItemColor: accentColor,
        unselectedItemColor: textLightColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withOpacity(0.1),
        thickness: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    return lightTheme;
  }
} 