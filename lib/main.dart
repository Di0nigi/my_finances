import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'persistentstorage.dart';
import 'package:my_finances/graph.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(new Myapp());

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  Widget build(BuildContext context) {
    return MaterialApp(home: _Home());
  }
}

class _Home extends StatefulWidget {
  @override
  State<_Home> createState() => _HomeState();
}

int entry_count = 0;
List<entry> entry_list = [];

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController _textEditingController = TextEditingController();
    TextEditingController _textEditingController2 = TextEditingController();
    //double _currentSliderValue = 20;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            actions: [
              GestureDetector(
                  onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(title: const Text('New Entry'), actions: <
                              Widget>[
                            Center(
                                child: Container(
                              width: 700,
                              height: 500,
                              color: Color.fromARGB(0, 255, 255, 255),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 100),
                                      child: TextField(
                                        controller: _textEditingController,
                                        decoration: InputDecoration(
                                          labelText: 'Transaction Value',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 100),
                                      child: TextField(
                                          controller: _textEditingController2,
                                          decoration: InputDecoration(
                                            labelText: 'Type of transaction',
                                          )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        updateDatabase(
                                            int.parse(
                                                _textEditingController.text),
                                            _textEditingController2.text,
                                            "null");
                                        updateview();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 43, 161, 0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        width: 80,
                                        height: 60,
                                        child: Center(child: Text("Enter")),
                                      ),
                                    )
                                  ]),
                            ))
                          ])),
                  child: Container(
                    height: 0,
                    width: 50,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ))
            ],
            backgroundColor: Color.fromARGB(255, 40, 218, 0),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          child: Column(children: [
            Container(
                width: width,
                height: height - 70 - 79.1,
                color: Color.fromARGB(255, 0, 0, 0),
                child: ListView.builder(
                  itemCount: entry_count, // Replace with your data list length
                  itemBuilder: (BuildContext context, int index) {
                    // Replace with your widget for each item in the list
                    return entry_list[index];
                  },
                )),
            GestureDetector(
                onTap: () {
                  graphit(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: width,
                  height: 70,
                  child: Center(child: Text("GRAPH IT!")),
                ))
          ]),
        ),
      ),
    );
  }
}

Future<File> _getFile(String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  return File('$path/$filename');
}

Future<void> saveText(String filename, String text) async {
  final file = await _getFile(filename);
  await file.writeAsString(text);
}

class entry extends StatelessWidget {
  final double height;
  final double width;
  final int id;

  entry({required this.height, required this.width, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            //padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
            height: height,
            width: width,
            child: Center(
              child: Text(
                id.toString(),
                style: TextStyle(
                  letterSpacing: 0,
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )));
  }
}

void graphit(context) {
  List<FlSpot> dataList = [
    FlSpot(0, 4),
    FlSpot(1, 3.5),
    FlSpot(2, 4.5),
    FlSpot(3, 1),
    FlSpot(4, 4),
    FlSpot(5, 6),
    FlSpot(6, 6.5),
    FlSpot(7, 6),
    FlSpot(8, 4),
    FlSpot(9, 6),
    FlSpot(10, 6),
    FlSpot(11, 7),
  ];

  Widget graphPage = Graph(data: dataList);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => graphPage),
  );
}

void updateview() async {
  List<Purchase> liste = await getallPurchases();
  entry_count = liste.length;
  for (int i = 0; i >= entry_count; i++) {
    var f = entry(
      height: 60,
      width: 500,
      id: liste[i].amount,
    );
    entry_list.add(f);
  }
}

void updateDatabase(int n, String s1, String s2) async {
  Purchase(n, s1, s2);
}
