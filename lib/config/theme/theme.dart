import 'package:dd/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static final theme = ThemeData(
    fontFamily: 'Satoshi',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.grey),
        // fillColor: AppColors.lightGrey,
        // filled: true,
        focusColor: AppColors.purple,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: AppColors.purple),
            borderRadius: BorderRadius.circular(12)),
        // labelStyle:
        //     const TextStyle(fontWeight: FontWeight.w600),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: const TextStyle(
            color: AppColors.purple, fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.purple),
            borderRadius: BorderRadius.circular(12))),
  );
}
