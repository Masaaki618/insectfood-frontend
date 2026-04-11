import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/features/insects/models/insect.dart';

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
}
