import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Color color = Colors.cyan;

class Graph extends StatefulWidget {
  final List<FlSpot> data;
  const Graph({super.key, required this.data});

  @override
  State<Graph> createState() => _graphState(data);
}

class _graphState extends State<Graph> {
  List<FlSpot> points;

  _graphState(this.points);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 700,
            height: 700,
            color: Color.fromARGB(255, 255, 255, 255),
            child: LineChart(LineChartData(
              lineTouchData: LineTouchData(enabled: false),
              lineBarsData: [
                LineChartBarData(
                    spots: points, isCurved: true, barWidth: 8, color: color),
              ],
            ))));
  }
}
