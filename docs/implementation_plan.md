# 実装計画｜昆虫食初心者ガイド フロントエンド

---

## フェーズ構成

| フェーズ | 目的 | 含むIssue |
|---|---|---|
| **Phase 1: Walking Skeleton** | パッケージ・ルーティング・APIクライアントの骨格を作り、画面遷移が通る最小構成を確立する | #1〜#2 |
| **Phase 2: コア機能実装** | 4画面 + 3エンドポイント連携をFeature単位で実装し、MVPを動かせる状態にする | #3〜#7 |
| **Phase 3: UI・堅牢化** | ローディング・エラー状態・テーマを整備し、ユーザーに届けられる品質にする | #8〜#9 |
| **Phase 4: 結合・リリース準備** | バックエンド本番APIとの疎通確認・ビルド検証を行い、リリース可能な状態にする | #10 |

---

## 依存関係マップ

```
#1（基盤構築）
  └─→ #2（テーマ・共通スタイル）
        ├─→ #3（昆虫一覧画面）
        │     └─→ #4（昆虫詳細画面）
        │           └─→ #7（トップ画面）
        └─→ #5（診断フロー画面）
              └─→ #6（診断結果画面）
                    └─→ #7（トップ画面）
                          └─→ #8（ローディング・エラー表示整備）
                                └─→ #9（共通ウィジェット・UIレビュー）
                                      └─→ #10（結合確認・リリース準備）
```

---

## Issueアウトライン表

### Issue #1: プロジェクト基盤を構築する
**概要**: `pubspec.yaml` に必要なパッケージを追加し、`go_router` のルーティング骨格・`dio` ベースの `ApiClient`・`Riverpod` の初期化を完了させる。`main.dart` を起動するとトップ画面へ遷移する最小構成。
**依存**: -
**ラベル**: `frontend`, `infra`
**AC**:
- [ ] `pubspec.yaml` に `flutter_riverpod`, `dio`, `go_router`, `fl_chart` が追加されている
- [ ] `shared/api/api_client.dart` に `dio` の初期化・ベースURL設定が実装されている
- [ ] `app.dart` に `go_router` で5画面分のルートが定義されている（画面本体は空でよい）
- [ ] `main.dart` で `ProviderScope` がルートに設定されており、`flutter run` でアプリが起動する
- [ ] `.env.example` にバックエンドAPIのベースURLキーが記載されている

---

### Issue #2: テーマ・共通スタイルを定義する
**概要**: `shared/theme/` にアプリ全体のカラー・テキストスタイル・難易度★表示ウィジェットを定義する。後続Issueでデザインがブレないようにする。
**依存**: #1
**ラベル**: `frontend`
**AC**:
- [ ] `shared/theme/app_colors.dart` にプライマリカラーなど主要色が定義されている
- [ ] `shared/theme/app_text_styles.dart` に見出し・本文・キャプションのスタイルが定義されている
- [ ] `shared/widgets/difficulty_stars.dart` に難易度★（1〜5）を表示するウィジェットが実装されている
- [ ] `app.dart` の `ThemeData` に上記テーマが適用されている

---

### Issue #3: 昆虫一覧画面を実装する
**概要**: `GET /api/v1/insects` を呼び出し、昆虫カード一覧を表示する。`Insect` モデル・`InsectRepository`・`InsectsProvider`・`InsectsPage` を一式実装する。
**依存**: #2
**ラベル**: `frontend`
**AC**:
- [ ] `features/insects/models/insect.dart` に `Insect` モデルが `../../docs/04_api.md` のレスポンス形式に沿って定義されている
- [ ] `features/insects/repositories/insect_repository.dart` が `GET /api/v1/insects` を呼び出して `List<Insect>` を返す
- [ ] `features/insects/providers/insects_provider.dart` が `AsyncValue<List<Insect>>` を提供する
- [ ] `InsectsPage` に昆虫カード（画像・名前・難易度★）一覧が表示される
- [ ] 昆虫カードをタップすると昆虫詳細画面（`/insects/:id`）に遷移する
- [ ] データ取得中はローディングインジケーターが表示される（簡易実装でよい）

---

### Issue #4: 昆虫詳細画面を実装する
**概要**: `GET /api/v1/insects/:id` を呼び出し、昆虫情報・AIコメント・`fl_chart` によるレーダーチャートを表示する。
**依存**: #3
**ラベル**: `frontend`
**AC**:
- [ ] `features/insects/repositories/insect_repository.dart` に `GET /api/v1/insects/:id` 呼び出しが追加されている
- [ ] `InsectDetailPage` に昆虫画像・名前・難易度★・説明・味・食感・AIコメントが表示される
- [ ] `fl_chart` を使ったレーダーチャートが `radar_chart`（umami/bitter/egu/flavor/kimo）の5軸で表示される
- [ ] 存在しないIDでアクセスした場合にエラーメッセージが表示される
- [ ] 戻るボタンで昆虫一覧画面に戻れる

---

### Issue #5: 診断フロー画面を実装する
**概要**: `GET /api/v1/questions` を呼び出し、6問を1問ずつ「はい/いいえ」で回答する画面を実装する。カテゴリ別スコアを状態として保持する。
**依存**: #2
**ラベル**: `frontend`
**AC**:
- [ ] `features/questions/models/question.dart` に `Question` モデルが定義されている
- [ ] `features/questions/repositories/question_repository.dart` が `GET /api/v1/questions` を呼び出して `List<Question>` を返す
- [ ] `DiagnosisPage` に質問文・「はい」「いいえ」ボタン・進捗バー（Q1/6）が表示される
- [ ] 回答ごとにカテゴリ別スコア（visual/physical/mental）が `DiagnosisProvider` で加算される
- [ ] 6問回答完了後、診断結果画面（`/diagnosis/result`）に自動遷移する

---

### Issue #6: 診断結果画面を実装する
**概要**: `POST /api/v1/diagnosis` にカテゴリ別スコアを送信し、AIがレコメンドした昆虫とコメントを表示する。
**依存**: #5
**ラベル**: `frontend`
**AC**:
- [ ] `features/diagnosis/repositories/diagnosis_repository.dart` が `POST /api/v1/diagnosis` を呼び出し、レスポンスをモデルにマッピングする
- [ ] `DiagnosisResultPage` にレコメンド昆虫の画像・名前・難易度★・AIコメントが表示される
- [ ] 「もう一度診断する」ボタンで診断フロー画面に戻り、スコアがリセットされる
- [ ] 「昆虫の詳細を見る」ボタンでレコメンド昆虫の詳細画面に遷移できる
- [ ] 「一覧を見る」ボタンで昆虫一覧画面に遷移できる

---

### Issue #7: トップ画面を実装する
**概要**: アプリのランディングページ。アプリの説明・診断の概要・診断開始ボタン・昆虫一覧ボタンを実装する。
**依存**: #3, #6
**ラベル**: `frontend`
**AC**:
- [ ] `features/top/pages/top_page.dart` に `../../docs/05_sitemap.md` 記載の主要UI要素（ターゲット説明・メリット・診断説明）が表示される
- [ ] 3つの耐性（👁 見た目・🤚 食べる勇気・💪 挑戦する気持ち）の説明が表示される
- [ ] 「診断開始」ボタンで診断フロー画面（`/diagnosis`）に遷移する
- [ ] 「昆虫一覧を見る」ボタンで昆虫一覧画面（`/insects`）に遷移する
- [ ] `flutter run` でトップ画面からすべての画面に遷移できることを手動確認できる

---

### Issue #8: ローディング・エラー状態を全画面に整備する
**概要**: 全画面で `AsyncValue` の `loading`・`error` 状態を統一的にハンドリングする。エラー時はリトライボタン付きのメッセージを表示する。
**依存**: #7
**ラベル**: `frontend`
**AC**:
- [ ] `shared/widgets/loading_indicator.dart` に共通ローディングウィジェットが実装されている
- [ ] `shared/widgets/error_view.dart` に「再試行」ボタン付きの共通エラーウィジェットが実装されている
- [ ] 昆虫一覧・昆虫詳細・診断フロー・診断結果の各画面で上記共通ウィジェットが使われている
- [ ] API通信のタイムアウト（例：10秒）が `ApiClient` に設定されている
- [ ] オフライン時にエラービューが表示され、アプリがクラッシュしない

---

### Issue #9: UIレビュー・共通ウィジェットの整理
**概要**: `flutter analyze` を通し、重複ウィジェットを `shared/widgets/` に集約して全体のコードを整理する。
**依存**: #8
**ラベル**: `frontend`
**AC**:
- [ ] `flutter analyze` で Warning・Error が0件
- [ ] 2画面以上で使われているウィジェットが `shared/widgets/` に切り出されている
- [ ] 昆虫カード（一覧・結果画面共通）が `InsectCard` ウィジェットとして共通化されている
- [ ] ハードコードされた文字列・マジックナンバーが残っていない

---

### Issue #10: バックエンド本番APIとの結合確認・リリース準備
**概要**: バックエンドのCloud Run本番URLに向けて全エンドポイントの疎通確認を行い、iOS/Androidのビルドが通ることを確認する。
**依存**: #9（バックエンド #14 完了後）
**ラベル**: `frontend`, `infra`
**AC**:
- [ ] 本番APIのベースURLを環境変数に設定し、4エンドポイントすべてが正常レスポンスを返す
- [ ] `flutter build ios --release` / `flutter build apk --release` がエラーなく完了する
- [ ] 実機（またはシミュレーター）で診断 → 結果表示 → 詳細閲覧の一連フローが動作する
- [ ] Claude APIのAIコメントが診断結果・昆虫詳細画面に表示される
- [ ] `README.md` にビルド・実行手順が記載されている

---

## 要確認事項

1. **モックデータの方針**: バックエンド完成前にフロント先行開発する場合、Repositoryをモック実装に差し替えるか、`json_server` 等のモックサーバーを立てるか決める必要がある
2. **画像（insect_img）の扱い**: 初期データで画像URLが `null` のとき、フロント側でプレースホルダー画像を表示するか確認が必要
3. **`ai_comment` のキー名統一**: `../../docs/04_api.md` の診断レスポンスと `openapi.yml` のキー名に齟齬がある場合は先に確定させる
4. **環境変数の管理方法**: FlutterでAPIのベースURLを注入する方法（`--dart-define` vs `.env` パッケージ）を決める必要がある
5. **iOS/Androidの最低サポートバージョン**: リリース先（TestFlight / Play Console 等）に合わせた設定が必要かどうか確認が必要
