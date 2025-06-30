import 'dart:math';
import 'package:flutter/material.dart';

class BarChartPainter extends CustomPainter {
  final List<int> data;
  final List<String> days;
  final AnimationController controller;

  BarChartPainter(
      {required this.data, required this.days, required this.controller});

  final barPainter = Paint()..color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    const double padding = 20;
    final int top = data.reduce(max);

    final double chartWidth = w - padding * 2;
    final double chartHeight = h - padding * 2;

    const double totalBarWidthRatio = 0.7;
    final int numGaps = data.length - 1;
    final double barWidth = (chartWidth * totalBarWidthRatio) / data.length;
    const minBarWidth = 10.0;
    final double maxBarWidth = chartWidth / data.length;
    final double finalBarWidth = barWidth.clamp(minBarWidth, maxBarWidth);
    final double finalBarPadding =
        numGaps > 0 ? (chartWidth - finalBarWidth * data.length) / numGaps : 0;

    final double heightPerUnit = chartHeight / top;

    for (int index = 0; index < data.length; index++) {
      final double barHeight = data[index] * heightPerUnit * controller.value;

      final double left = padding + index * (finalBarWidth + finalBarPadding);
      final double right = left + finalBarWidth;
      final double bottom = h - padding;
      final double top = h - (padding + barHeight);

      final rect = Rect.fromLTRB(left, top, right, bottom);

      canvas.drawRect(rect, barPainter);
    }
  }

  @override
  bool shouldRepaint(covariant BarChartPainter oldDelegate) {
    return true;
  }
}
