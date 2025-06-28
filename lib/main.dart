import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_graph_learn/line_chart.dart';

void main() {
  runApp(MaterialApp(
    home: Entry(),
    debugShowCheckedModeBanner: false,
  ));
}

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final List<int> data = [50, 30, 40, 50, 100, 30, 0];
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chart"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "Line Chart",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              height: 500,
              child: CustomPaint(
                painter: LineChartPainter(
                    data: data, days: days, primary: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
