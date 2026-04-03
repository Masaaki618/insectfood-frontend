### 背景 / 目的
診断完了後、カテゴリ別スコアをバックエンドに送信してAIのレコメンドと昆虫を表示する。
`POST /api/v1/diagnosis` を呼び出し、診断結果画面を実装する。

- 依存: #5
- ラベル: `frontend`

### スコープ / 作業項目

バックエンドの層構成に対応させて実装する。

| 作成ファイル | バックエンド対応 | 役割 |
|---|---|---|
| `features/diagnosis/models/diagnosis.dart` | `models/`（dtos/diagnosis_dto.go） | データモデル定義 |
| `features/diagnosis/repositories/diagnosis_repository_interface.dart` | `repositories/*_interface.go` | 抽象クラス（DI用） |
| `features/diagnosis/repositories/diagnosis_repository.dart` | `repositories/` | APIアクセス実装 |
| `features/diagnosis/pages/diagnosis_result_page.dart` | `controllers/diagnosis_controller.go` | 画面表示 |

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `features/diagnosis/repositories/diagnosis_repository_interface.dart` に `IDiagnosisRepository` 抽象クラスが定義されている
- [ ] `features/diagnosis/repositories/diagnosis_repository.dart` が `POST /api/v1/diagnosis` にスコアを送信し、レスポンスをモデルにマッピングできる
- [ ] `DiagnosisResultPage` にレコメンド昆虫の画像・名前・難易度★・AIコメントが表示される
- [ ] 「もう一度診断する」ボタンで `/diagnosis` に戻り、スコアがリセットされる
- [ ] 「昆虫の詳細を見る」ボタンでレコメンド昆虫の `/insects/:id` に遷移できる
- [ ] 「一覧を見る」ボタンで `/insects` に遷移できる

### テスト観点

- 手動確認:
  - 診断フローを完了してスコアが正しくAPIに送信されること（バックエンドのログで確認）
  - AIコメントとレコメンド昆虫が画面に表示されること
  - 「もう一度診断する」後にスコアがリセットされ、最初の問題から始まること
  - 各ボタンの遷移先が正しいこと
- 検証方法: バックエンド起動状態でのエミュレーター手動操作

### 参考: リクエスト / レスポンス形式（`../../../docs/04_api.md` より）

**リクエスト**
```json
{
  "scores": {
    "visual": 2,
    "physical": 1,
    "mental": 0
  }
}
```

**レスポンス**
```json
{
  "insect": {
    "id": 3,
    "name": "シルクワーム",
    "difficulty": 2,
    "introduction": "白くてまるっとした見た目で初心者向け",
    "taste": "クリーミー",
    "texture": "もちもち",
    "insect_img": "https://example.com/images/silkworm.png"
  },
  "ai_comment": "見た目への耐性は高いあなたですが..."
}
```

### 要確認事項

- Claude APIエラー時のデフォルトコメントはバックエンドが返すので、フロント側の特別な処理は不要。ただしAPIが503を返した場合のフロント表示を確認する。
