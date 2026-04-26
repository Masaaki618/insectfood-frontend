import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:frontend/features/insects/models/insect.dart';
import 'package:frontend/shared/theme/app_colors.dart';

/// 味覚レーダーチャートを表示するウィジェット
///
/// 昆虫食の5つの味覚特性（旨味、苦味、エグ味、風味、キモみ）をレーダーチャートで可視化します。
/// 各スコア値は0～5の範囲で、中央の値ほど味が薄く、外側ほど濃いことを表します。
///
/// 表示例：
/// - 旨味が高い場合、上側の領域が大きく広がります
/// - 複数の味が高い場合、多角形の形状で全体的なバランスが見えます
class RadarChartWidget extends StatelessWidget {
  final RadarChart radarChart;

  const RadarChartWidget({super.key, required this.radarChart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 340,
        height: 340,
        child: CustomPaint(
          // RadarChartPainterに描画ロジックを委譲
          painter: RadarChartPainter(
            scores: [
              radarChart.umamiScore.toDouble(),
              radarChart.bitterScore.toDouble(),
              radarChart.eguScore.toDouble(),
              radarChart.flavorScore.toDouble(),
              radarChart.kimoScore.toDouble(),
            ],
            labels: const ['旨味', '苦味', 'エグ味', '風味', 'キモみ'],
            maxValue: 5,
          ),
        ),
      ),
    );
  }
}

/// レーダーチャートを描画するカスタムペインター
///
/// CustomPainter を使用してCanvas上に直接描画することで、
/// 複雑な図形を効率的に描画できます。
///
/// 描画の流れ：
/// 1. グリッド線（5段階の背景枠）を描画
/// 2. ラベルとスコア値を各軸の外側に配置
/// 3. データエリア（塗りつぶされた多角形）を描画
/// 4. データポイント（ドット）を描画
class RadarChartPainter extends CustomPainter {
  final List<double> scores;        // 5つのスコア値（0.0～5.0）
  final List<String> labels;        // 軸のラベル（旨味、苦味など）
  final double maxValue;            // スコアの最大値（通常は5）

  // ペイントスタイルの定数
  // これらの値を統一することで、デザインの一貫性を保ちます
  static const _gridAlpha = 64;           // グリッド線の透明度（薄い灰色）
  static const _axisAlpha = 77;           // 軸線の透明度（グリッドより濃い）
  static const _gridStrokeWidth = 0.5;    // グリッド線と軸線の幅
  static const _dataStrokeWidth = 2.0;    // データエリアの枠線の幅
  static const _pointRadius = 4.0;        // データポイント（ドット）の半径
  static const _labelFontSize = 13.0;     // ラベルのフォントサイズ
  static const _labelRadius = 30.0;       // ラベルを配置する距離（中心からの）
  static const _labelMaxWidth = 60.0;     // ラベルテキストの最大幅

  RadarChartPainter({
    required this.scores,
    required this.labels,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // チャートの中心座標を計算
    final center = Offset(size.width / 2, size.height / 2);
    // チャートの最大半径（画面の端までの距離）
    // 40のマージンを引くことで、ラベルが画面外に出ないようにします
    final maxRadius = size.width / 2 - 40;

    // 描画順序は重要です（背景から前面へ）
    _drawGrid(canvas, center, maxRadius);      // 背景のグリッド線
    _drawLabels(canvas, center, maxRadius);    // ラベルとスコア値
    _drawDataArea(canvas, center, maxRadius);  // データエリア（塗りつぶし + 枠線）
    _drawDataPoints(canvas, center, maxRadius); // データポイント（最前面）
  }

  /// グリッド線と軸線を描画
  ///
  /// グリッド線：5段階の背景となる正五角形
  /// 軸線：中心から各ラベル方向への直線
  ///
  /// この組み合わせにより、ユーザーはスコア値をグリッド線と照らし合わせて
  /// 簡単に値を読み取ることができます。
  void _drawGrid(Canvas canvas, Offset center, double maxRadius) {
    // グリッド線のペイント設定
    final gridPaint = Paint()
      ..color = Colors.grey.withAlpha(_gridAlpha)  // 薄い灰色
      ..style = PaintingStyle.stroke                // 枠線のみ（塗りつぶし無し）
      ..strokeWidth = _gridStrokeWidth;

    // 5段階のグリッド線を描画（0%, 20%, 40%, 60%, 80%, 100%）
    for (int i = 1; i <= 5; i++) {
      final radius = (maxRadius / 5) * i;
      _drawPolygon(canvas, center, radius, scores.length, gridPaint);
    }

    // 各軸（旨味、苦味など）の方向を示す線のペイント設定
    final axisPaint = Paint()
      ..color = Colors.grey.withAlpha(_axisAlpha)  // グリッドより濃い灰色
      ..style = PaintingStyle.stroke
      ..strokeWidth = _gridStrokeWidth;

    // 5本の軸線を描画（5つの味覚特性に対応）
    for (int i = 0; i < scores.length; i++) {
      final point = _polarToCartesian(center, maxRadius, i, scores.length);
      canvas.drawLine(center, point, axisPaint); // 中心からラベル方向への線
    }
  }

  /// ラベルとスコア値を描画
  ///
  /// 各軸の外側にラベル（旨味など）とスコア値を配置します。
  /// テキストは常に中央揃えされるため、読みやすくなっています。
  void _drawLabels(Canvas canvas, Offset center, double maxRadius) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,  // テキストを中央揃えにする
    );

    // 5つの軸それぞれにラベルとスコア値を配置
    for (int i = 0; i < labels.length; i++) {
      // ラベルを配置する座標を計算
      // _labelRadius分外側に配置することで、グリッドと重ならないようにします
      final point = _polarToCartesian(
        center,
        maxRadius + _labelRadius,
        i,
        scores.length,
      );

      // スコア値は整数で表示（例：3, 4）
      final scoreValue = scores[i].round();
      // ラベルとスコア値を改行で区切って配置
      final labelText = '${labels[i]}\n$scoreValue';

      // テキストのスタイルを設定
      textPainter.text = TextSpan(
        text: labelText,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: _labelFontSize,
          fontWeight: FontWeight.bold,
          height: 1.2,  // 行間を調整して視認性を向上
        ),
      );

      // テキストのレイアウトを計算（最大幅を60に制限）
      textPainter.layout(maxWidth: _labelMaxWidth);

      // テキストを中央揃えで描画
      textPainter.paint(
        canvas,
        Offset(
          point.dx - textPainter.width / 2,    // 横方向の中央
          point.dy - textPainter.height / 2,   // 縦方向の中央
        ),
      );
    }
  }

  /// データエリア（塗りつぶし + 枠線）を描画
  ///
  /// スコア値を座標に変換した5つのポイントを結んで多角形を作り、
  /// 塗りつぶし（薄い緑色）と枠線（濃い緑色）で表現します。
  void _drawDataArea(Canvas canvas, Offset center, double maxRadius) {
    // スコア値を座標に変換
    final points = _getDataPoints(center, maxRadius);

    // 多角形のパスを作成
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);  // 最初のポイントに移動
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);  // 次のポイントへ線を引く
    }
    path.close();  // 最後のポイントと最初のポイントを繋ぐ

    // 塗りつぶし（薄い緑色で透明度75%）
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.primary.withAlpha(150)  // 半透明の緑
        ..style = PaintingStyle.fill,               // 塗りつぶし
    );

    // 枠線（濃い緑色）でデータエリアの輪郭を強調
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.primary               // 濃い緑
        ..style = PaintingStyle.stroke            // 枠線のみ
        ..strokeWidth = _dataStrokeWidth,         // 2pxの太さ
    );
  }

  /// データポイント（ドット）を描画
  ///
  /// 各スコア値の位置に小さな円を描画することで、
  /// ユーザーが正確なポイント位置を認識しやすくなります。
  void _drawDataPoints(Canvas canvas, Offset center, double maxRadius) {
    // スコア値を座標に変換
    final points = _getDataPoints(center, maxRadius);

    // ドットのペイント設定（濃い緑色）
    final pointPaint = Paint()
      ..color = AppColors.primary       // 濃い緑
      ..style = PaintingStyle.fill;     // 塗りつぶし

    // 5つのドットを描画
    for (final point in points) {
      canvas.drawCircle(point, _pointRadius, pointPaint);
    }
  }

  /// 極座標をデカルト座標に変換
  ///
  /// レーダーチャートは極座標系（中心からの距離と角度）で考えられます。
  /// Canvas上に描画するには、これを直交座標系（x, y）に変換する必要があります。
  ///
  /// 計算式：
  /// x = center.x + radius * cos(angle)
  /// y = center.y + radius * sin(angle)
  ///
  /// [index]: 軸のインデックス（0～4で5つの軸に対応）
  /// [sides]: 軸の総数（通常は5）
  /// 戻り値: 変換されたデカルト座標
  Offset _polarToCartesian(
    Offset center,
    double radius,
    int index,
    int sides,
  ) {
    // 角度を計算（360°を軸の数で分割）
    // -π/2することで、最初の軸が上（12時の方向）を指すようにします
    final angle = (2 * math.pi * index / sides) - math.pi / 2;

    // 極座標をデカルト座標に変換
    return Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
  }

  /// スコア値を座標に変換したデータポイント群を取得
  ///
  /// このメソッドは _drawDataArea と _drawDataPoints の両方で使用されます。
  /// 同じ座標を使うことで、データエリアとドットの位置が正確に一致するようにします。
  ///
  /// 戻り値: スコア値に対応した5つの座標の配列
  List<Offset> _getDataPoints(Offset center, double maxRadius) {
    return scores
        .asMap()
        .entries
        .map((e) {
          // スコア値をグリッド内の割合に正規化（0～1の範囲に）
          // 例：スコア3、maxValue 5 → 0.6（グリッドの60%の位置）
          final normalizedScore = e.value / maxValue;

          // 正規化されたスコアに最大半径を掛けて、実際の半径を計算
          return _polarToCartesian(
            center,
            normalizedScore * maxRadius,  // スコア値に対応した半径
            e.key,                        // 軸のインデックス
            scores.length,                // 軸の総数
          );
        })
        .toList();
  }

  /// 正多角形を描画
  ///
  /// 指定された数の頂点を持つ正多角形を描画します。
  /// レーダーチャートでは、5角形（正五角形）が複数段重ねられて
  /// グリッド線を形成します。
  ///
  /// [sides]: 多角形の頂点数（通常は5）
  void _drawPolygon(
    Canvas canvas,
    Offset center,
    double radius,
    int sides,
    Paint paint,
  ) {
    final path = Path();

    // 各頂点を計算して多角形を作成
    for (int i = 0; i < sides; i++) {
      final point = _polarToCartesian(center, radius, i, sides);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);  // 最初の頂点に移動
      } else {
        path.lineTo(point.dx, point.dy);  // 次の頂点へ線を引く
      }
    }
    path.close();  // 最後の頂点と最初の頂点を繋ぐ

    // Canvas上に描画
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    // スコア値が変わった場合のみ再描画が必要
    return oldDelegate.scores != scores;
  }
}
