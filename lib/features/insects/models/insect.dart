class Insect {
  final int id;
  final String name;
  final int difficulty;
  final String introduction;
  final String taste;
  final String texture;
  final String insectImg;

  Insect({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.introduction,
    required this.taste,
    required this.texture,
    required this.insectImg,
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
    );
  }
}
