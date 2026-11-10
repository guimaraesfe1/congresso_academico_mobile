import 'package:flutter/material.dart';

/// Cores e tema compartilhados por todos os módulos do aplicativo.
class AppColors {
  static const primaria = Color(0xFF1B4332);
  static const secundaria = Color(0xFF2D6A4F);
  static const destaque = Color(0xFF52B788);
  static const containerClaro = Color(0xFFD8F3DC);
  static const superficieSuave = Color(0xFFE8F2EC);
  static const borda = Color(0xFFD3E0D8);
  static const fundo = Color(0xFFF7FBF8);
  static const textoForte = Color(0xFF0F261C);
  static const textoSuave = Color(0xFF52615B);
}

class AppTheme {
  static ThemeData get tema {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.fundo,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaria,
        primary: AppColors.primaria,
        secondary: AppColors.secundaria,
        primaryContainer: AppColors.containerClaro,
        onPrimaryContainer: const Color(0xFF081C15),
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.primaria,
        foregroundColor: Colors.white,
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: AppColors.borda),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.borda),
        ),
      ),
      chipTheme: const ChipThemeData(elevation: 0, pressElevation: 0),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaria,
      ),
    );
  }
}
