import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/features/insects/models/insect.dart';
import 'package:frontend/features/questions/models/question.dart';

class ApiClient {
  static late final Dio _dio;

  static void initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080/api/v1',
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  // getInsects() メソッド（実際にAPIを呼ぶ）
  Future<List<Insect>> getInsects() async {
    final response = await _dio.get('/insects');
    return (response.data as List)
        .map((json) => Insect.fromJson(json))
        .toList();
  }

  Future<Insect> getInsectById(int id) async {
    final response = await _dio.get('/insects/$id');
    return Insect.fromJson(response.data);
  }

  Future<List<Question>> getQuestions() async {
    final response = await _dio.get('/questions');
    return (response.data as List)
        .map((json) => Question.fromJson(json))
        .toList();
  }
}
