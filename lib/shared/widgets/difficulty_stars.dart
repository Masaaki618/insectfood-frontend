import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// 難易度を★で表示するウィジェット
/// difficulty: 1〜5の整数を受け取る
class DifficultyStars extends StatelessWidget {
  final int difficulty;

  const DifficultyStars({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 16,
          color: index < difficulty
              ? AppColors.starFilled
              : AppColors.starEmpty,
        );
      }),
    );
  }
}
