### 背景 / 目的
診断機能のコア部分。`GET /api/v1/questions` で取得した6問を1問ずつ表示し、
はい/いいえの回答からカテゴリ別スコア（visual/physical/mental）を積み上げる。

- 依存: #2
- ラベル: `frontend`

### スコープ / 作業項目

バックエンドの層構成に対応させて実装する。

> **`questions/providers/` は作らない**
> バックエンドは `question_service.go` が独立しているが、フロントでは質問リストの取得とスコアの管理が診断フローとして一体なので、`DiagnosisProvider` にまとめる。`questions/` featureは `models/` と `repositories/` のみ。

| 作成ファイル | バックエンド対応 | 役割 |
|---|---|---|
| `features/questions/models/question.dart` | `models/question.go` | データモデル定義 |
| `features/questions/repositories/question_repository_interface.dart` | `repositories/question_repository_interface.go` | 抽象クラス（DI用） |
| `features/questions/repositories/question_repository.dart` | `repositories/question_repository.go` | APIアクセス実装 |
| `features/diagnosis/providers/diagnosis_provider.dart` | `services/diagnosis_service.go` | 質問リスト＋スコアの一括管理 |
| `features/diagnosis/pages/diagnosis_page.dart` | `controllers/diagnosis_controller.go` | 画面表示 |

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `features/questions/models/question.dart` に `Question` モデルが `../../../docs/04_api.md` のレスポンス（`id` / `body` / `category`）に対応して定義されている
- [ ] `features/questions/repositories/question_repository_interface.dart` に `IQuestionRepository` 抽象クラスが定義されている
- [ ] `features/questions/repositories/question_repository.dart` が `GET /api/v1/questions` を呼び出して `List<Question>` を返す
- [ ] `DiagnosisPage` に質問文・「はい」「いいえ」ボタン・進捗バー（Q1/6）が表示される
- [ ] 「はい（1点）」「いいえ（0点）」の回答ごとにカテゴリ別スコアが `DiagnosisProvider` で加算される
- [ ] 6問回答完了後、`/diagnosis/result` に自動遷移する

### テスト観点

- 手動確認:
  - 6問すべてに「はい」と回答したとき各カテゴリスコアが2になること
  - 6問すべてに「いいえ」と回答したとき各カテゴリスコアが0になること
  - 進捗バーが Q1/6 → Q6/6 と正しく進むこと
  - 6問回答後に診断結果画面へ遷移すること
- 検証方法: エミュレーターでの手動操作

### 参考: 診断ロジック（`../../../docs/01_requirements.md` より）

| カテゴリ | 出題数 | スコア範囲 |
|---|---|---|
| visual | 2問 | 0〜2点 |
| physical | 2問 | 0〜2点 |
| mental | 2問 | 0〜2点 |

- はい = 1点 / いいえ = 0点
