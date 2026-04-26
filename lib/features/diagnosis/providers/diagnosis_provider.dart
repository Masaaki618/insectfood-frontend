import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/questions/models/question.dart';
import 'package:frontend/features/questions/repositories/question_repository.dart';
import 'package:frontend/shared/api/api_client.dart';

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
  final QuestionRepository _repository;

  DiagnosisStateNotifier(this._repository)
      : super(DiagnosisState(
          currentQuestion: 1,
          questions: [],
          answers: [0, 0, 0, 0, 0, 0],
          categoryScores: {'visual': 0, 'physical': 0, 'mental': 0},
          isLoading: true,
        )) {
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await _repository.getQuestions();
      state = state.copyWith(
        questions: questions,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  void answerQuestion(int answer) {
    final newAnswers = [...state.answers];
    newAnswers[state.currentQuestion - 1] = answer;

    final newScores = _calculateCategoryScores(newAnswers);

    state = state.copyWith(
      answers: newAnswers,
      categoryScores: newScores,
    );
  }

  void nextQuestion() {
    if (state.currentQuestion < 6) {
      state = state.copyWith(
        currentQuestion: state.currentQuestion + 1,
      );
    }
  }

  void previousQuestion() {
    if (state.currentQuestion > 1) {
      state = state.copyWith(
        currentQuestion: state.currentQuestion - 1,
      );
    }
  }

  void reset() {
    state = DiagnosisState(
      currentQuestion: 1,
      questions: state.questions,
      answers: [0, 0, 0, 0, 0, 0],
      categoryScores: {'visual': 0, 'physical': 0, 'mental': 0},
      isLoading: false,
    );
  }

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

final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return QuestionRepository(ApiClient());
});

final diagnosisStateProvider =
    StateNotifierProvider<DiagnosisStateNotifier, DiagnosisState>((ref) {
  final repository = ref.watch(questionRepositoryProvider);
  return DiagnosisStateNotifier(repository);
});
