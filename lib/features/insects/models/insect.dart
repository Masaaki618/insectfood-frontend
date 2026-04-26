class Insect {
  final int id;
  final String name;
  final int difficulty;
  final String introduction;
  final String taste;
  final String texture;
  final String insectImg;
  final String? aiComment;
  final RadarChart? radarChart;

  Insect({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.introduction,
    required this.taste,
    required this.texture,
    required this.insectImg,
    this.aiComment,
    this.radarChart,
  });

  factory Insect.fromJson(Map<String, dynamic> json) {
    return Insect(
      id: json['id'],
      name: json['name'],
      difficulty: json['difficulty'],
      introduction: json['introduction'],
      taste: json['taste'],
      texture: json['texture'],
      insectImg: json['insect_img'],
      aiComment: json['ai_comment'],
      radarChart: json['radar_chart'] != null
          ? RadarChart.fromJson(json['radar_chart'])
          : null,
    );
  }
}

class RadarChart {
  final int umamiScore;
  final int bitterScore;
  final int eguScore;
  final int flavorScore;
  final int kimoScore;

  RadarChart({
    required this.umamiScore,
    required this.bitterScore,
    required this.eguScore,
    required this.flavorScore,
    required this.kimoScore,
  });

  factory RadarChart.fromJson(Map<String, dynamic> json) {
    return RadarChart(
      umamiScore: json['umami_score'] ?? 0,
      bitterScore: json['bitter_score'] ?? 0,
      eguScore: json['egu_score'] ?? 0,
      flavorScore: json['flavor_score'] ?? 0,
      kimoScore: json['kimo_score'] ?? 0,
    );
  }

  // アニメーション再実行時の比較に必要
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadarChart &&
          runtimeType == other.runtimeType &&
          umamiScore == other.umamiScore &&
          bitterScore == other.bitterScore &&
          eguScore == other.eguScore &&
          flavorScore == other.flavorScore &&
          kimoScore == other.kimoScore;

  @override
  int get hashCode =>
      umamiScore.hashCode ^
      bitterScore.hashCode ^
      eguScore.hashCode ^
      flavorScore.hashCode ^
      kimoScore.hashCode;
}
