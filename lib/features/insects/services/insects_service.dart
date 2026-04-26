import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/insects/models/insect.dart';
import 'package:frontend/features/insects/repositories/insect_repository.dart';
import 'package:frontend/shared/api/api_client.dart';

final insectRepositoryProvider = Provider<InsectRepository>((ref) {
  final apiClient = ApiClient();
  return InsectRepository(apiClient);
});

final insectsProvider = FutureProvider<List<Insect>>((ref) async {
  final repository = ref.watch(insectRepositoryProvider);
  return await repository.getInsects();
});

final insectDetailProvider = FutureProvider.family<Insect, int>((ref, id,) async {
  final repository = ref.watch(insectRepositoryProvider);
  return await repository.getInsectById(id);
});
