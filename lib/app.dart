import 'package:flutter/material.dart';
import 'package:frontend/features/insects/pages/insects_list_page.dart';
import 'package:frontend/shared/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

// アプリのルート定義
// 画面遷移のルートをすべてここで管理する
final _router = GoRouter(
  initialLocation: '/insects', // ← ここを変更
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('トップ画面'))),
    ),
    GoRoute(
      path: '/diagnosis',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('診断フロー画面'))),
    ),
    GoRoute(
      path: '/diagnosis/result',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('診断結果画面'))),
    ),
    GoRoute(path: '/insects', builder: (context, state) => InsectsListPage()),
    GoRoute(
      path: '/insects/:id',
      builder: (context, state) {
        // context: 親ウィジェットツリーの情報
        //   → MediaQuery.of(context)で画面サイズ取得
        //   → Navigator.of(context)で画面遷移

        // state: このルートに渡されたパラメータ情報
        //   → pathParameters['id'] で /insects/:id の :id を取得
        //   → queryParameters で ?foo=bar を取得
        final id = state.pathParameters['id'];
        return Scaffold(
          appBar: AppBar(
            title: Text("詳細画面：insects/$id"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(), // go() から pop() に戻す
            ),
          ),
          body: Center(child: Text("詳細画面：insects/$id")),
        );
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
