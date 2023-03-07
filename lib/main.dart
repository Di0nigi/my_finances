import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

int entry_count = 100;

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //double _currentSliderValue = 20;
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            actions: [
              GestureDetector(
                  onTap: () => showDialog<String>(
        context: context,                
                    builder:(BuildContext context) => AlertDialog(
                          title: const Text('New Entry'),
                          actions: <Widget>[
                            Center(child:Container(width: 700,height: 500,
                            color: Color.fromARGB(0, 255, 255, 255),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                              child: TextField(
                                decoration: InputDecoration(
                                      labelText: 'Transaction Value',
  ),),),
                              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                              child: TextField(
                                decoration: InputDecoration(
                                      labelText: 'Type of transaction',
  )
                              ),),
                              GestureDetector(child: Container(
                                decoration: BoxDecoration(color: Color.fromARGB(255, 43, 161, 0),borderRadius: BorderRadius.all(Radius.circular(20))),
                                width: 80,
                                height: 60,
                                child: Center(child:Text("Enter")),
                              ),)
                              ]
                            ),
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
                    return entry(height: 60, width: width, id: index);
                  },
                )),
            Container(
              width: width,
              height: 70,
              color: Color.fromARGB(255, 255, 0, 0),
            )
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

Widget popup() {
  return AlertDialog(
    actions: [
      Container(
        width: 100,
        height: 100,
        color: Color.fromARGB(255, 255, 0, 0),
      )
    ],
  );
}
