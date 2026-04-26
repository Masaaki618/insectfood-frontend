import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/diagnosis/providers/diagnosis_provider.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class DiagnosisPage extends ConsumerWidget {
  const DiagnosisPage({super.key});

  String _getCategoryEmoji(String category) {
    switch (category) {
      case 'visual':
        return '👁';
      case 'physical':
        return '🤚';
      case 'mental':
        return '💪';
      default:
        return '❓';
    }
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'visual':
        return '見た目への耐性';
      case 'physical':
        return '食べる勇気';
      case 'mental':
        return '挑戦する気持ち';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosis = ref.watch(diagnosisStateProvider);

    if (diagnosis.isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '質問を読み込み中...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (diagnosis.error != null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text('エラーが発生しました: ${diagnosis.error}'),
        ),
      );
    }

    if (diagnosis.questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(
          child: Text('質問が取得できませんでした'),
        ),
      );
    }

    final currentQuestion = diagnosis.questions[diagnosis.currentQuestion - 1];
    final progressPercentage = (diagnosis.currentQuestion / 6 * 100).toInt();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 進捗表示
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '質問${diagnosis.currentQuestion}/6',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '$progressPercentage%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // プログレスバー
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: diagnosis.currentQuestion / 6,
                    minHeight: 6,
                    backgroundColor: Colors.grey.withAlpha(77),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 質問カード
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // カテゴリラベル
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getCategoryEmoji(currentQuestion.category),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _getCategoryLabel(currentQuestion.category),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 質問文
                      Text(
                        currentQuestion.body,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // はい/いいえボタン
                      Row(
                        children: [
                          // はいボタン
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(diagnosisStateProvider.notifier)
                                    .answerQuestion(1);

                                if (diagnosis.currentQuestion == 6) {
                                  context.push('/diagnosis/result');
                                } else {
                                  ref
                                      .read(diagnosisStateProvider.notifier)
                                      .nextQuestion();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'はい',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // いいえボタン
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(diagnosisStateProvider.notifier)
                                    .answerQuestion(0);

                                if (diagnosis.currentQuestion == 6) {
                                  context.push('/diagnosis/result');
                                } else {
                                  ref
                                      .read(diagnosisStateProvider.notifier)
                                      .nextQuestion();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.withAlpha(77),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'いいえ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // テスト用：結果を見るボタン
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            context.push('/diagnosis/result');
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppColors.primary,
                              width: 1,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            '結果を見る（テスト用）',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
