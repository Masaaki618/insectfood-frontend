import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// アプリのルート定義
/// 画面遷移のルートをすべてここで管理する
final _router = GoRouter(
  initialLocation: '/',
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
    GoRoute(
      path: '/insects',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('昆虫一覧画面'))),
    ),
    GoRoute(
      path: '/insects/:id',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('昆虫詳細画面'))),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: '昆虫食初心者ガイド', routerConfig: _router);
  }
}
