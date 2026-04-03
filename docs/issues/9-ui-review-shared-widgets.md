### 背景 / 目的
#3〜#8 で実装した画面全体を横断してコードを見直し、重複Widgetの共通化・Lint警告の解消を行う。
リリース前の品質確保フェーズとして `flutter analyze` をクリーンに通す状態を作る。

- 依存: #8
- ラベル: `frontend`

### スコープ / 作業項目

- `flutter analyze` の Warning / Error をすべて解消する
- 2画面以上で使われているWidgetを `shared/widgets/` に切り出す
  - 昆虫カード（昆虫一覧・診断結果画面で共通）→ `InsectCard` として共通化
- ハードコードされた文字列・マジックナンバーを定数に置き換える
- 不要な `TODO:` コメントを削除する

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `flutter analyze` で Warning・Error が0件
- [ ] 2画面以上で使われているWidgetが `shared/widgets/` に切り出されている
- [ ] 昆虫カード（一覧画面・診断結果画面で共通表示する部分）が `InsectCard` Widgetとして共通化されている
- [ ] ハードコードされた文字列・マジックナンバーが定数化されている

### テスト観点

- 静的解析:
  - `flutter analyze` がエラー・警告0件で通ること
- 手動確認:
  - 共通化後も各画面の表示が変わっていないことをエミュレーターで確認
- 検証方法: `flutter analyze` コマンド + 目視確認
