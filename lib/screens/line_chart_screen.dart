import 'package:flutter/material.dart';

import '../painter/line_chart.dart';

class LineChartScreen extends StatefulWidget {
  final List<int> data;
  final List<String> days;

  const LineChartScreen({super.key, required this.data, required this.days});

  @override
  State<LineChartScreen> createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              "Line Chart",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: Colors.purple.withAlpha(200),
              borderRadius: BorderRadius.circular(20)),
          width: double.infinity,
          height: 500,
          child: CustomPaint(
            painter: LineChartPainter(
                data: widget.data,
                days: widget.days,
                primary: Colors.white,
                controller: _controller),
          ),
        ),
      ],
    );
  }
}
