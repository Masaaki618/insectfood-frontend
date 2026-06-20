import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/diagnosis/models/diagnosis_result.dart';
import 'package:frontend/features/diagnosis/repositories/diagnosis_repository.dart';
import 'package:frontend/shared/api/api_client.dart';

/// DiagnosisRepositoryを提供するプロバイダー
/// APIクライアントを初期化してリポジトリを生成
final diagnosisRepositoryProvider = Provider<DiagnosisRepository>((ref) {
  return DiagnosisRepository(ApiClient());
});

/// スコアを送信して診断結果を取得するプロバイダー
/// [scores]: カテゴリ別スコアのマップ
/// ローディング・エラー・データの各状態を管理
final diagnosisResultProvider =
    FutureProvider.family<DiagnosisResult, Map<String, int>>((ref, scores) async {
  final repository = ref.watch(diagnosisRepositoryProvider);
  return await repository.postDiagnosis(scores);
});
