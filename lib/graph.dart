import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_finances/main.dart';
import 'package:my_finances/persistentstoragenew.dart';

Color color = Colors.cyan;
List<FlSpot> points = [];

class Graph extends StatefulWidget {
  final List<Purchase> data;
  const Graph({super.key, required this.data});

  @override
  State<Graph> createState() => _graphState(data);
}

class _graphState extends State<Graph> {
  List<Purchase> data;

  _graphState(this.data);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    points = formatData();
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          width: width,
          height: 450,
          color: Color.fromARGB(255, 255, 255, 255),
          child: LineChart(LineChartData(
            //maxX: width,
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                dotData: FlDotData(show: true),
                  spots: points, isCurved: true, barWidth: 8, color: color,),
            ],
          )))
    ]));
  }

  List<FlSpot> formatData() {
    int x = 0;
    List<FlSpot> dataList = <FlSpot>[];
    List<Purchase> allpurchases = this.data;
    Set<DateTime> SD = Set();
    Map<String, int> MD = Map();
    List<int> LI = [];
    DateTime last = allpurchases.first.dateTime_;
    for (Purchase item in allpurchases) {
      //LI.add(item.amount);
      DateTime date = item.dateTime_;
      SD.add(date);
      //var s = date.day.toString();
      if (date.day == last.day && date.month == last.month) {
        x += item.amount;
      } else {
        LI.add(x);
        x = 0;
        x += item.amount;
      }

      last = date;
    }
    LI.add(x);

    for (int i = 0; i < LI.length; i++) {
      FlSpot s = FlSpot(SD.first.day.toDouble(),LI[i].toDouble());
      SD.remove(SD.first);
      dataList.add(s);
    }

    return dataList;
  }
}
