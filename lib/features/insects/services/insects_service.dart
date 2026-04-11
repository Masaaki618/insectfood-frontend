import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/insects/models/insect.dart';
import 'package:frontend/features/insects/repositories/insect_repository.dart';
import 'package:frontend/shared/api/api_client.dart';

final insectsProvider = FutureProvider<List<Insect>>((ref) async {
  final apiClient = ApiClient();
  final repository = InsectRepository(apiClient);
  return await repository.getInsects();
});
