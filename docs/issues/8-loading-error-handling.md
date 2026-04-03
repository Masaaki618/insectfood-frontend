### 背景 / 目的
全画面に共通のローディング・エラーUIを整備する。
現状は各画面が独自実装になりがちなため、`shared/widgets/` に共通化して統一された体験を提供する。

- 依存: #7
- ラベル: `frontend`

### スコープ / 作業項目

- `shared/widgets/loading_indicator.dart` を作成する（共通ローディングWidget）
- `shared/widgets/error_view.dart` を作成する（「再試行」ボタン付き共通エラーWidget）
- 昆虫一覧・昆虫詳細・診断フロー・診断結果の各画面で上記共通Widgetに差し替える
- `shared/api/api_client.dart` にタイムアウト設定を追加する（10秒）

### ゴール / 完了条件（Acceptance Criteria）

- [ ] `shared/widgets/loading_indicator.dart` に共通ローディングWidgetが実装されている
- [ ] `shared/widgets/error_view.dart` に「再試行」ボタン付きの共通エラーWidgetが実装されている
- [ ] 昆虫一覧・昆虫詳細・診断フロー・診断結果の各画面でRiverpodの `AsyncValue.loading` / `AsyncValue.error` に上記共通Widgetが使われている
- [ ] `ApiClient` にタイムアウト（10秒）が設定されている
- [ ] オフライン状態でアプリを起動してもクラッシュしない

### テスト観点

- 手動確認:
  - ネットワークをオフにした状態で各画面を開き、エラーViewと「再試行」ボタンが表示されること
  - 「再試行」ボタンをタップするとAPIを再取得すること
  - エミュレーターのネットワーク速度を「低速」に設定してローディング表示が確認できること
- 検証方法: エミュレーターのネットワーク設定を変更して手動確認
