import 'package:dio/dio.dart';

/// API通信の共通クライアント
/// ベースURLやヘッダーの設定をまとめる
class ApiClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        // --dart-define=API_BASE_URL=... で起動時に注入する
        baseUrl: const String.fromEnvironment('API_BASE_URL'),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}
