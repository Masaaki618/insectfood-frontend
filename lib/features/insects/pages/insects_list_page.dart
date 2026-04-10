import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/insects/services/insects_service.dart';
import 'package:frontend/shared/widgets/difficulty_stars.dart';
import 'package:go_router/go_router.dart';

class InsectsListPage extends ConsumerWidget {
  const InsectsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider から昆虫一覧を取得
    final insectsAsync = ref.watch(insectsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("昆虫一覧")),
      body: insectsAsync.when(
        data: (insects) => ListView.builder(
          itemCount: insects.length,
          itemBuilder: (context, index) {
            final insect = insects[index];
            return GestureDetector(
              onTap: () => context.push('/insects/${insect.id}'),
              child: Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: insect.insectImg.isNotEmpty
                      ? Image.network(insect.insectImg, width: 50)
                      : const Icon(Icons.bug_report),
                  title: Text(insect.name),
                  subtitle: Text(insect.introduction),
                  trailing: DifficultyStars(difficulty: insect.difficulty),
                ),
              ),
            );
          },
        ), // ローディング中
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラー: $err')),
      ),
    );
  }
}
