import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/questions/models/question.dart';

class DiagnosisState {
  final int currentQuestion;
  final List<Question> questions;
  final List<int> answers;
  final Map<String, int> categoryScores;
  final bool isLoading;
  final String? error;

  DiagnosisState({
    required this.currentQuestion,
    required this.questions,
    required this.answers,
    required this.categoryScores,
    required this.isLoading,
    this.error,
  });

  /// 指定したフィールドのみを更新した新しいDiagnosisStateを生成します
  /// 指定されなかったフィールドは元の値を保持します
  DiagnosisState copyWith({
    int? currentQuestion,
    List<Question>? questions,
    List<int>? answers,
    Map<String, int>? categoryScores,
    bool? isLoading,
    String? error,
  }) {
    return DiagnosisState(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      categoryScores: categoryScores ?? this.categoryScores,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DiagnosisStateNotifier extends StateNotifier<DiagnosisState> {
  DiagnosisStateNotifier({
    List<Question> questions = const [],
    bool isLoading = false,
  }) : super(DiagnosisState(
          currentQuestion: 1,
          questions: questions,
          answers: [0, 0, 0, 0, 0, 0],
          categoryScores: {'visual': 0, 'physical': 0, 'mental': 0},
          isLoading: isLoading,
        ));

  /// APIから取得した質問リストを状態に保存し、ローディング状態を終了します
  void setQuestions(List<Question> questions) {
    state = state.copyWith(
      questions: questions,
      isLoading: false,
    );
  }

  /// 質問取得エラーを状態に記録し、ローディング状態を終了します
  void setError(String error) {
    state = state.copyWith(
      error: error,
      isLoading: false,
    );
  }

  /// 現在の質問に対する回答を記録し、カテゴリ別スコアを再計算します
  /// [answer]: 0 (いいえ) or 1 (はい)
  void answerQuestion(int answer) {
    final newAnswers = [...state.answers];
    newAnswers[state.currentQuestion - 1] = answer;

    final newScores = _calculateCategoryScores(newAnswers);

    state = state.copyWith(
      answers: newAnswers,
      categoryScores: newScores,
    );
  }

  /// 次の質問に進みます（質問6までのみ進行可能）
  void nextQuestion() {
    if (state.currentQuestion < 6) {
      state = state.copyWith(
        currentQuestion: state.currentQuestion + 1,
      );
    }
  }

  /// 前の質問に戻ります（質問1より前には戻れません）
  void previousQuestion() {
    if (state.currentQuestion > 1) {
      state = state.copyWith(
        currentQuestion: state.currentQuestion - 1,
      );
    }
  }

  /// 診断をリセットし、最初の質問に戻します
  /// 質問リストと状態の初期値に戻します
  void reset() {
    state = DiagnosisState(
      currentQuestion: 1,
      questions: state.questions,
      answers: [0, 0, 0, 0, 0, 0],
      categoryScores: {'visual': 0, 'physical': 0, 'mental': 0},
      isLoading: false,
    );
  }

  /// 回答リストからカテゴリ別スコアを計算します
  /// 各質問の category フィールドで分類し、スコアを集計します
  Map<String, int> _calculateCategoryScores(List<int> answers) {
    final scores = {'visual': 0, 'physical': 0, 'mental': 0};

    for (final (index, answer) in answers.indexed) {
      if (index < state.questions.length) {
        final category = state.questions[index].category;
        scores[category] = (scores[category] ?? 0) + answer;
      }
    }

    return scores;
  }
}

final diagnosisStateProvider =
    StateNotifierProvider<DiagnosisStateNotifier, DiagnosisState>((ref) {
  return DiagnosisStateNotifier(isLoading: true);
});
