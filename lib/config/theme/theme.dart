import 'package:dd/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static final theme = ThemeData(
      fontFamily: 'Satoshi',
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
      chipTheme: chipTheme,
      inputDecorationTheme: dropDownInputDecoration);

  static final dropDownInputDecoration = InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.grey),
      focusColor: AppColors.purple,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)));

  static final taskInputDecoration = InputDecoration(
      labelText: 'Task name',
      hintStyle: const TextStyle(color: AppColors.grey),
      focusColor: AppColors.purple,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle:
          const TextStyle(color: AppColors.purple, fontWeight: FontWeight.w600),
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)));

  static InputDecoration inputDecoration({String? label, String? hint}) => InputDecoration(
    hintText: hint,
      labelText: label,
      hintStyle: const TextStyle(color: AppColors.grey),
      focusColor: AppColors.purple,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle:
          const TextStyle(color: AppColors.purple, fontWeight: FontWeight.w600),
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)));

  static final dateInputDecoration = InputDecoration(
      prefixIcon: const Icon(Icons.calendar_month_outlined),
      hintText: 'task deadline',
      labelText: 'End date',
      hintStyle: const TextStyle(color: AppColors.grey),
      focusColor: AppColors.purple,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle:
          const TextStyle(color: AppColors.purple, fontWeight: FontWeight.w600),
      border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AppColors.purple),
          borderRadius: BorderRadius.circular(12)));

  static final chipTheme = ChipThemeData(
    showCheckmark: false,
    // backgroundColor: AppColors.grey,
    side: BorderSide.none,
    labelStyle: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.black),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    // color: WidgetStateProperty.all(AppColors.seed)
  );
}
