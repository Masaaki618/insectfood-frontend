import 'package:frontend/shared/api/api_client.dart';
import 'package:frontend/features/insects/models/insect.dart';

class InsectRepository {
  final ApiClient _apiClient;

  InsectRepository(this._apiClient);

  Future<List<Insect>> getInsects() {

    return _apiClient.getInsects(); // ← インスタンスメソッドとして呼ぶ
  }
}
