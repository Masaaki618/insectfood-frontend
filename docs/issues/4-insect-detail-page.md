### 背景 / 目的
ユーザーが昆虫の詳細情報（味・食感・レーダーチャート・AIコメント）を確認できる画面を実装する。
`GET /api/v1/insects/:id` を呼び出し、`fl_chart` で5軸のレーダーチャートを表示する。

- 依存: #3
- ラベル: `frontend`

### スコープ / 作業項目

- `features/insects/repositories/insect_repository.dart` に `GET /api/v1/insects/:id` の呼び出しを追加する
- `features/insects/repositories/insect_repository_interface.dart` にメソッドを追加する
- `features/insects/pages/insect_detail_page.dart` に `InsectDetailPage` を実装する
- `fl_chart` を使ったレーダーチャートウィジェットを実装する（5軸: umami/bitter/egu/flavor/kimo）
- `app.dart` の `/insects/:id` ルートに `InsectDetailPage` を接続する

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `IInsectRepository` と `InsectRepository` に `getInsectById(int id)` が追加されている
- [ ] `InsectDetailPage` に昆虫画像・名前・難易度★・説明・味・食感・AIコメントが表示される
- [ ] `fl_chart` を使ったレーダーチャートが5軸（旨味・苦味・エグ味・風味・キモみ）で表示される
- [ ] 存在しないIDでアクセスした場合にエラーメッセージが表示される（アプリがクラッシュしない）
- [ ] 戻るボタンで昆虫一覧画面に戻れる

### テスト観点

- 手動確認:
  - 昆虫一覧からカードをタップして詳細画面に遷移し、全情報が表示されること
  - レーダーチャートの各スコア（1〜5）が正しく描画されること
  - 存在しないID（例: `/insects/9999`）にアクセスしてエラーが表示されること
- 検証方法: エミュレーターでの手動操作

### 参考: レスポンス形式（`../../../docs/04_api.md` より）

```json
{
  "id": 1,
  "name": "コオロギパウダー",
  "difficulty": 1,
  "introduction": "粉末状なので虫とわからない初心者向け",
  "taste": "ナッツ系",
  "texture": "サラサラ",
  "insect_img": "https://example.com/images/cricket.png",
  "ai_comment": "ナッツ系の香ばしい風味が特徴...",
  "radar_chart": {
    "umami_score": 3,
    "bitter_score": 1,
    "egu_score": 1,
    "flavor_score": 4,
    "kimo_score": 1
  }
}
```
