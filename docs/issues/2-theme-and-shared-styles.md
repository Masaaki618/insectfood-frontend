### 背景 / 目的
後続Issueで各画面を実装するにあたり、カラーやテキストスタイルをバラバラに定義するとデザインがブレる。
`shared/theme/` にアプリ全体のデザイントークンを集約し、統一感のあるUIの土台を作る。

- 依存: #1
- ラベル: `frontend`

### スコープ / 作業項目

- `lib/shared/theme/app_colors.dart` を作成する（プライマリカラーなど主要色の定数定義）
- `lib/shared/theme/app_text_styles.dart` を作成する（見出し・本文・キャプションのTextStyle定義）
- `lib/shared/widgets/difficulty_stars.dart` を作成する（難易度★1〜5を表示するWidget）
- `lib/app.dart` の `MaterialApp` に上記テーマを `ThemeData` として適用する

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `shared/theme/app_colors.dart` にプライマリカラーなど主要色が定数として定義されている
- [ ] `shared/theme/app_text_styles.dart` に見出し・本文・キャプションの `TextStyle` が定義されている
- [ ] `shared/widgets/difficulty_stars.dart` に難易度（1〜5の整数）を受け取り★で表示するWidgetが実装されている
- [ ] `app.dart` の `ThemeData` に `app_colors` と `app_text_styles` が適用されている

### テスト観点

- 手動確認:
  - `flutter run` でテーマが適用された状態でアプリが起動すること
  - `DifficultyStars(difficulty: 3)` を仮置きして★3つが正しく表示されること
- 検証方法: エミュレーターでの目視確認

### 要確認事項

- アプリのメインカラーをどの色にするか（デザインカンプがなければ仮色で進めてよいか確認）
