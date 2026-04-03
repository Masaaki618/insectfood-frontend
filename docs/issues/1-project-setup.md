### 背景 / 目的
Flutter開発を始めるにあたり、状態管理・API通信・画面遷移の基盤を整備する必要がある。
`Riverpod` / `dio` / `go_router` を導入し、`flutter run` でアプリが起動する最小構成を確立する。

- 依存: -
- ラベル: `frontend`, `infra`

### スコープ / 作業項目

- `pubspec.yaml` に以下のパッケージを追加する
  - `flutter_riverpod`（状態管理 = バックエンドの Service 層相当）
  - `dio`（HTTP通信 = バックエンドの Repository 層で使用）
  - `go_router`（画面遷移 = バックエンドの routers/ 相当）
  - `fl_chart`（レーダーチャート描画）
- `lib/shared/api/api_client.dart` を作成する（dioの初期化・ベースURL設定）
- `lib/app.dart` を作成する（go_routerで5画面分のルート定義）
- `lib/main.dart` を修正する（`ProviderScope` をルートに設定）
- `.env.example` にAPIベースURLキーを記載する

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `pubspec.yaml` に `flutter_riverpod` / `dio` / `go_router` / `fl_chart` が追加されている
- [ ] `shared/api/api_client.dart` に `dio` の初期化・ベースURL設定が実装されている
- [ ] `app.dart` に go_router で以下5画面のルートが定義されている（画面本体は空Widgetでよい）: `/`・`/diagnosis`・`/diagnosis/result`・`/insects`・`/insects/:id`
- [ ] `main.dart` で `ProviderScope` がルートに設定されており、`flutter run` でアプリが起動する
- [ ] `.env.example` に `API_BASE_URL` キーが記載されている

### テスト観点

- 手動確認:
  - `flutter run` でアプリが起動し、エラーなくトップ画面（空でよい）が表示されること
  - `flutter analyze` が通ること
- 検証方法: エミュレーターまたは実機での起動確認

### 要確認事項

- APIベースURLの注入方法: `--dart-define` で渡すか、`.env` 系パッケージを使うか決める必要がある
- go_router のバージョン: 最新安定版（v14系）を使うか確認が必要
