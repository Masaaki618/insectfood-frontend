import 'package:frontend/features/insects/models/insect.dart';

/// 診断結果を表すモデル
/// AIが推奨した昆虫とパーソナライズコメントを含む
class DiagnosisResult {
  /// 推奨された昆虫の情報
  final Insect insect;

  /// AIが生成したパーソナライズコメント
  final String aiComment;

  DiagnosisResult({
    required this.insect,
    required this.aiComment,
  });

  /// JSONレスポンスからDiagnosisResultを生成
  factory DiagnosisResult.fromJson(Map<String, dynamic> json) {
    return DiagnosisResult(
      insect: Insect.fromJson(json['insect']),
      aiComment: json['ai_comment'],
    );
  }
}
