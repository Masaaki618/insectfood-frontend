import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/questions/models/question.dart';
import 'package:frontend/features/questions/repositories/question_repository.dart';
import 'package:frontend/shared/api/api_client.dart';

/// QuestionRepositoryを提供するプロバイダー
/// APIクライアントを初期化してリポジトリを生成します
final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return QuestionRepository(ApiClient());
});

/// APIから質問リストを非同期に取得するプロバイダー
/// ローディング・エラー・データの各状態を管理します
final questionsProvider = FutureProvider<List<Question>>((ref) async {
  final repository = ref.watch(questionRepositoryProvider);
  return await repository.getQuestions();
});
