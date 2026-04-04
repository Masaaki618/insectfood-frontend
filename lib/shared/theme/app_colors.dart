import 'package:flutter/material.dart';

/// アプリ全体で使用するカラー定数
class AppColors {
  AppColors._(); // インスタンス化を禁止する

  /// メインカラー（ボタン・アイコン・プログレスバー）
  static const Color primary = Color(0xFF3D9970);

  /// メインカラーの薄い版（背景・バッジ・コメントボックス）
  static const Color primaryLight = Color(0xFFF0FAF7);

  /// 画面全体の背景色
  static const Color background = Color(0xFFF0FAF7);

  /// メインテキスト（見出し・質問文）
  static const Color textPrimary = Color(0xFF1A2E2A);

  /// サブテキスト（説明文・ローディングテキスト）
  static const Color textSecondary = Color(0xFF555F6E);

  /// タグのテキスト色
  static const Color tagText = Color(0xFF2D7A5F);

  /// 難易度★の塗り色
  static const Color starFilled = Color(0xFFF5C518);

  /// 難易度★の空色
  static const Color starEmpty = Color(0xFFD1D5DB);

  /// 「いいえ」ボタンなどのセカンダリボタン背景
  static const Color buttonSecondary = Color(0xFFEEEEEE);
}
