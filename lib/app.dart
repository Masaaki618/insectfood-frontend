import 'package:flutter/material.dart';
import 'package:frontend/features/diagnosis/pages/diagnosis_page.dart';
import 'package:frontend/features/insects/pages/insects_list_page.dart';
import 'package:frontend/features/insects/pages/insect_detail_page.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

// アプリのルート定義
// 画面遷移のルートをすべてここで管理する
final _router = GoRouter(
  initialLocation: '/diagnosis', // ← 診断フロー画面を確認
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('トップ画面'))),
    ),
    GoRoute(
      path: '/diagnosis',
      builder: (context, state) => const DiagnosisPage(),
    ),
    GoRoute(
      path: '/diagnosis/result',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('診断結果画面'))),
    ),
    GoRoute(
      path: '/insects',
      builder: (context, state) => const InsectsListPage(),
    ),
    GoRoute(
      path: '/insects/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return InsectDetailPage(id: id);
      },
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '昆虫食初心者ガイド',
      routerConfig: _router,
      theme: ThemeData(
        // メインカラーをAppColors.primaryから自動生成
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        // 全画面の背景色をAppColors.backgroundに統一
        scaffoldBackgroundColor: AppColors.background,
      ),
    );
  }
}
