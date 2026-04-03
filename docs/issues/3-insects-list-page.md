### 背景 / 目的
ユーザーが登録済みの昆虫を一覧で閲覧できる画面を実装する。
`GET /api/v1/insects` を呼び出し、Riverpod の `AsyncValue` で状態管理しながら昆虫カード一覧を表示する。

- 依存: #2
- ラベル: `frontend`

### スコープ / 作業項目

バックエンドの層構成に対応させて実装する。

| 作成ファイル | バックエンド対応 | 役割 |
|---|---|---|
| `features/insects/models/insect.dart` | `models/insect.go` | データモデル定義 |
| `features/insects/repositories/insect_repository_interface.dart` | `repositories/insect_repository_interface.go` | 抽象クラス（DI用） |
| `features/insects/repositories/insect_repository.dart` | `repositories/insect_repository.go` | APIアクセス実装 |
| `features/insects/providers/insects_provider.dart` | `services/insect_service.go` | ビジネスロジック・状態管理 |
| `features/insects/pages/insects_page.dart` | `controllers/insect_controller.go` | 画面表示 |

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `features/insects/models/insect.dart` に `Insect` モデルが `../../../docs/04_api.md` のレスポンスJSON（`id` / `name` / `difficulty` / `introduction` / `taste` / `texture` / `insect_img`）に対応して定義されている
- [ ] `features/insects/repositories/insect_repository_interface.dart` に `IInsectRepository` 抽象クラスが定義されている
- [ ] `features/insects/repositories/insect_repository.dart` が `IInsectRepository` を実装し `GET /api/v1/insects` を呼び出す
- [ ] `features/insects/providers/insects_provider.dart` が `AsyncValue<List<Insect>>` を提供する
- [ ] `InsectsPage` に昆虫カード（画像・名前・難易度★）の一覧が表示される
- [ ] 昆虫カードをタップすると `/insects/:id` に遷移する

### テスト観点

- 手動確認:
  - バックエンドが起動している状態で `/insects` 画面を開き、昆虫一覧が表示されること
  - ネットワーク切断時にクラッシュせずエラー表示になること（簡易確認でよい）
  - 昆虫カードをタップして詳細画面へ遷移することを確認
- 検証方法: エミュレーターでの手動操作

### 参考: レスポンス形式（`../../../docs/04_api.md` より）

```json
[
  {
    "id": 1,
    "name": "コオロギパウダー",
    "difficulty": 1,
    "introduction": "粉末状なので虫とわからない初心者向け",
    "taste": "ナッツ系",
    "texture": "サラサラ",
    "insect_img": "https://example.com/images/cricket.png"
  }
]
```

### 要確認事項

- `insect_img` が `null` の場合のプレースホルダー画像をどうするか
- バックエンド未完成時にモックRepositoryで先行開発するかどうか（`IInsectRepository` があれば差し替え可能）
