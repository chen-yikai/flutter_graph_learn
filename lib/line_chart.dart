import 'dart:math';
import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final List<int> data;
  final List<String> days;
  final Color primary;

  late final Paint dotPaint;
  late final Paint linePaint;
  late final Paint gridPaint;

  final outlinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..color = Colors.transparent;

  LineChartPainter({
    required this.data,
    required this.days,
    required this.primary,
  }) {
    dotPaint = Paint()
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill
      ..color = primary;

    linePaint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = primary;

    gridPaint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = primary;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;
    const padding = 100.0;

    final double blockW = (w - padding) / data.length;
    final double blockH = h - padding;

    final Offset containerStart = Offset(blockW / 2 + padding / 2, h / 2);
    _drawContainerRect(canvas, containerStart, blockW, blockH);

    final top = data.reduce(max);
    final List<Offset> dotPoints =
        _drawDots(canvas, blockW, blockH, padding, top);
    _drawLine(canvas, dotPoints);
    _drawDayLabels(canvas, blockW, blockH, padding);
    _drawGrid(canvas, blockW, blockH, size, padding, top, 10);
  }

  void _drawGrid(
    Canvas canvas,
    double blockW,
    double blockH,
    Size size,
    double padding,
    int top,
    int space,
  ) {
    List<int> values =
        List.generate(space + 1, (i) => (top / space * i).toInt());

    for (int i = 0; i < values.length; i++) {
      double yValue = values[i].toDouble();

      double y = (blockH + padding / 2) - (yValue * (blockH / top));

      canvas.drawLine(
        Offset(padding / 2, y),
        Offset(size.width - padding / 2, y),
        gridPaint,
      );

      final label = TextSpan(
        text: yValue.toInt().toString(),
        style: TextStyle(color: primary, fontSize: 12),
      );
      final tp = TextPainter(
        text: label,
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(canvas, Offset(padding / 2 - tp.width - 5, y - tp.height / 2));
    }
  }

  void _drawContainerRect(
      Canvas canvas, Offset center, double width, double height) {
    for (var _ in data) {
      final rect =
          Rect.fromCenter(center: center, width: width, height: height);
      canvas.drawRect(rect, outlinePaint);
      center += Offset(width, 0);
    }
  }

  List<Offset> _drawDots(
      Canvas canvas, double blockW, double blockH, double padding, int top) {
    List<Offset> dotPoints = [];

    for (int i = 0; i < data.length; i++) {
      double x = blockW / 2 + padding / 2 + (i * blockW);
      double y = (blockH + padding / 2) - (data[i] * (blockH / top));
      Offset offset = Offset(x, y);
      dotPoints.add(offset);
      canvas.drawCircle(offset, 10, dotPaint);
    }

    return dotPoints;
  }

  void _drawLine(Canvas canvas, List<Offset> dotPoints) {
    Path path = Path();

    for (int i = 0; i < dotPoints.length - 1; i++) {
      path.moveTo(dotPoints[i].dx, dotPoints[i].dy);
      path.lineTo(dotPoints[i + 1].dx, dotPoints[i + 1].dy);
    }

    canvas.drawPath(path, linePaint);
  }

  void _drawDayLabels(
      Canvas canvas, double blockW, double blockH, double padding) {
    for (int i = 0; i < days.length; i++) {
      final textSpan = TextSpan(
        text: days[i],
        style: TextStyle(
          color: primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      final x = padding / 2 + blockW * i + blockW / 2 - textPainter.width / 2;
      final y = blockH + padding / 2 + textPainter.height - 5;

      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
