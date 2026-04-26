import '../models/question.dart';

abstract class IQuestionRepository {
  Future<List<Question>> getQuestions();
}
