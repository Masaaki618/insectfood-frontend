import 'package:frontend/shared/api/api_client.dart';

import '../models/question.dart';

class QuestionRepository {
  final ApiClient _apiClient;

  QuestionRepository(this._apiClient);

  Future<List<Question>> getQuestions() async {
    return await _apiClient.getQuestions();
  }
}
