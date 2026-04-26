import 'package:frontend/shared/api/api_client.dart';

import '../models/question.dart';
import 'question_repository_interface.dart';

class QuestionRepository implements IQuestionRepository {
  final ApiClient _apiClient;

  QuestionRepository(this._apiClient);

  @override
  Future<List<Question>> getQuestions() async {
    return await _apiClient.getQuestions();
  }
}
