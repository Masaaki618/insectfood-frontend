import 'package:frontend/features/diagnosis/models/diagnosis_result.dart';
import 'package:frontend/shared/api/api_client.dart';

/// 診断機能のAPI通信を担当するリポジトリ
class DiagnosisRepository {
  final ApiClient _apiClient;

  DiagnosisRepository(this._apiClient);

  /// スコアをサーバーに送信し、診断結果を取得
  /// [scores]: カテゴリ別スコア（visual/physical/mental）
  Future<DiagnosisResult> postDiagnosis(Map<String, dynamic> scores) async {
    return await _apiClient.postDiagnosis(scores);
  }
}
