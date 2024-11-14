import 'package:flutter/material.dart';

final class AppTheme {
  static const orangeColor = Color(0xFFFFAE45);
  static const ligthOrangeColor = Color(0xFFFFEFE9);
  static const blueColor = Color(0xFF01BDD6);
  static const ligthGreyColor = Color(0xFFFFEFE9);

  static final _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: ligthOrangeColor));

  static const titleStyle = TextStyle(
      color: AppTheme.blueColor, fontSize: 20, fontWeight: FontWeight.bold);

  static final ligthTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: ligthOrangeColor),
    useMaterial3: true,
    scaffoldBackgroundColor: ligthOrangeColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ligthOrangeColor,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: orangeColor,
        fontWeight: FontWeight.w700,
      ),
      floatingLabelStyle: const TextStyle(
        fontSize: 16,
        color: blueColor,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blueColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: orangeColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
  );

  // Impementar futuramente

  static final darkTheme = ligthTheme;
}
