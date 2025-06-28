import 'dart:math';

import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  final List<int> data;
  final List<String> days;
  final Color primary;

  late final Paint dotPaint;
  late final Paint linePaint;

  LineChartPainter(
      {required this.data, required this.days, required this.primary}) {
    dotPaint = Paint()
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill
      ..color = primary;

    linePaint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = primary;
  }

  final outlinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    // ..color = Colors.black;
    //
    ..color = Colors.transparent;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final w = size.width;
    const padding = 100;
    final double blockW = (w - padding) / data.length;
    final double blockH = (h - padding);

    _drawContainerRect(
        canvas, Offset(blockW / 2 + padding / 2, h / 2), blockW, blockH);

    var top = data.reduce((a, b) => max(a, b));
    List<Offset> dotPoint = [];

    data.asMap().entries.forEach((entry) {
      int index = entry.key;
      int item = entry.value;

      double x = blockW / 2 + padding / 2 + (index * blockW);
      double y = (blockH + padding / 2) - (item * (blockH / top));
      Offset offset = Offset(x, y);

      dotPoint.add(offset);
      canvas.drawCircle(offset, 10, dotPaint);
    });

    Path linePath = Path();
    dotPoint.asMap().entries.forEach((entry) {
      int index = entry.key;
      Offset offset = entry.value;
      linePath.moveTo(offset.dx, offset.dy);
      if (index + 1 != dotPoint.length) {
        Offset next = dotPoint[index + 1];
        linePath.lineTo(next.dx, next.dy);
      }
    });
    canvas.drawPath(linePath, linePaint);

    days.asMap().entries.forEach((entry) {
      int index = entry.key;
      String day = entry.value;

      var textSpan = TextSpan(
          text: day,
          style: TextStyle(
              color: primary, fontSize: 20, fontWeight: FontWeight.bold));

      var textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              padding / 2 +
                  (blockW * index) +
                  blockW / 2 -
                  textPainter.width / 2,
              blockH + padding / 2 + textPainter.height - 5));
    });
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
