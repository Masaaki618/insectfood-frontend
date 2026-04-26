class Question {
  final int id;
  final String body;
  final String category;

  Question({
    required this.id,
    required this.body,
    required this.category,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      body: json['body'],
      category: json['category'],
    );
  }
}
