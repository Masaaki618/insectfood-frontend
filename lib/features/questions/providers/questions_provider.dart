import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/questions/models/question.dart';
import 'package:frontend/features/questions/repositories/question_repository.dart';
import 'package:frontend/shared/api/api_client.dart';

final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return QuestionRepository(ApiClient());
});

final questionsProvider = FutureProvider<List<Question>>((ref) async {
  final repository = ref.watch(questionRepositoryProvider);
  return await repository.getQuestions();
});
