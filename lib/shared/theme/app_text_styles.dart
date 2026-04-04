import 'package:flutter/material.dart';
import 'app_colors.dart';

/// アプリ全体で使用するテキストスタイル定数
class AppTextStyles {
  AppTextStyles._(); // インスタンス化を禁止する

  /// 大見出し（画面タイトルなど）
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// 中見出し（セクションタイトルなど）
  static const TextStyle subheadline = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// 本文
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  /// キャプション（補足テキスト・ローディングテキストなど）
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
