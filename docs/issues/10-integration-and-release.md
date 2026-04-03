### 背景 / 目的
バックエンドの本番API（Cloud Run）が完成した後、フロントエンドと繋いで全エンドポイントの疎通を確認する。
iOS / Android のリリースビルドが通ることを確認し、アプリをリリース可能な状態にする。

- 依存: #9（バックエンド #14 完了後）
- ラベル: `frontend`, `infra`

### スコープ / 作業項目

- `ApiClient` のベースURLを本番URL（`https://your-api.run.app/api/v1`）に向ける
- 4エンドポイント（`GET /insects` / `GET /insects/:id` / `GET /questions` / `POST /diagnosis`）の疎通確認
- `flutter build ios --release` / `flutter build apk --release` を実行してビルドが通ることを確認する
- `README.md` にビルド・実行手順を記載する

### ゴール / 完了条件（Acceptance Criteria）

- [ ] 本番APIのベースURLを設定し、4エンドポイントすべてが正常レスポンスを返す
- [ ] `flutter build ios --release` がエラーなく完了する
- [ ] `flutter build apk --release` がエラーなく完了する
- [ ] 実機（またはシミュレーター）で「診断 → 結果表示 → 昆虫詳細閲覧」の一連フローが動作する
- [ ] `README.md` にビルド・実行手順が記載されている

### テスト観点

- 結合確認:
  - 本番APIに繋いで診断フロー全体（質問取得 → スコア送信 → AI結果表示）が動くこと
  - 昆虫一覧・詳細のAIコメントとレーダーチャートが表示されること
- リリースビルド確認:
  - `flutter build` コマンドがエラーなく通ること
- 検証方法: 実機またはエミュレーターでの手動操作 + ビルドコマンドの実行

### 要確認事項

- ベースURLの本番切り替え方法: `--dart-define` フラグで渡すか、ビルド環境ごとに設定ファイルを分けるか
- App Store / Google Play へ提出する場合は別途アカウント・証明書の準備が必要
