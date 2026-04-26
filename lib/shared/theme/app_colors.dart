import 'package:flutter/material.dart';

/// アプリ全体で使用するカラー定数
class AppColors {
  AppColors._(); // インスタンス化を禁止する

  /// メインカラー（ボタン・アイコン・プログレスバー）
  static const Color primary = Color(0xFF3D9970);

  /// メインカラーの薄い版（背景・バッジ・コメントボックス）
  static const Color primaryLight = Color(0xFFF0FAF7);

  /// セカンダリ背景色（食感セクション等）
  static const Color secondaryLight = Color(0xFFEEF2FF);

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

  /// 白色（カード背景）
  static const Color white = Color(0xFFFFFFFF);

  /// グレー（テキスト・シャドウ等）
  static const Color grey = Color(0xFF9E9E9E);

  /// グレー薄い版（シャドウ色）
  static const Color greyShadow = Color(0x199E9E9E);

  /// グレー極薄版（グリッド線）
  static const Color greyUltraLight = Color(0x08000000);

  /// グレー極薄版（目盛・グリッド）
  static const Color greyVeryLight = Color(0x1F000000);

  /// グレー（レーダーチャートの軸線と同じ色）
  static const Color greyAxis = Color(0x4D9E9E9E);
}
