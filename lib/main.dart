import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'persistentstoragenew.dart';
import 'package:my_finances/graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:my_finances/entry.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding();
  prefs = await SharedPreferences.getInstance();
  await prefs!.setStringList("allitems", <String>[]);
  runApp(const Myapp());
}

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

int entry_count = 1;
List<entry> entry_list = [];
Widget listView_ = updateview();
Widget last_used = Wlist.first;

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController _textEditingController = TextEditingController();
    _textEditingController.text = "";
    TextEditingController _textEditingController2 = TextEditingController();
    _textEditingController2.text = "";
    TextEditingController _textEditingController3 = TextEditingController();
    _textEditingController3.text = "";

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
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _textEditingController,
                                        decoration: InputDecoration(
                                          labelText: 'Transaction Value',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                                      child: TextField(
                                          controller: _textEditingController2,
                                          decoration: InputDecoration(
                                            labelText: 'Type of transaction',
                                          )),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 100),
                                        child: DropdownMenu_()),
                                    GestureDetector(
                                      onTap: () {
                                        DateTime dateTime = DateTime.now();
                                        updateDatabase(
                                            int.parse(
                                                _textEditingController.text),
                                            _textEditingController2.text,
                                            _textEditingController3.text,
                                            dateTime);
                                        setState(() {
                                          listView_ = updateview();
                                        });
                                        Navigator.pop(context);
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
                child: listView_),
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

List<Widget> Wlist = <Widget>[];

void createL(List<String> l) {
  for (String s in l) {
    Widget W = dropOption(s);

    Wlist.add(W);
  }
}

class DropdownMenu_ extends StatefulWidget {
  const DropdownMenu_({super.key});

  @override
  State<DropdownMenu_> createState() => DropdownMenuState();
}

class DropdownMenuState extends State<DropdownMenu_> {
  Widget dropdownValue = last_used;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        child: DropdownButton<Widget>(
          value: dropdownValue,
          //icon: const Icon(Icons.arrow_downward),
          elevation: 0,
          onChanged: (Widget? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: Wlist.map<DropdownMenuItem<Widget>>((Widget value) {
            return DropdownMenuItem<Widget>(
              value: value,
              child: Text("eo"),
            );
          }).toList(),
        ));
  }
}

class dropOption extends StatelessWidget {
  final String title;
  // final Function() onTap;

  dropOption(this.title);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap(),
      child: Container(
        child: Text(title),
      ),
    );
  }

  String select() {
    return this.title;
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

Widget updateview() {
  List<Purchase> liste = getallPurchases();

  entry_count = liste.length;
  print(entry_count);

  for (int i = 0; i < entry_count; i++) {
    print("trig");
    var f = entry(
      height: 60,
      width: 500,
      amount: liste[i].amount,
      id: liste[i].id,
    );
    if (entry_list.length <= 0) {
      entry_list.add(f);
    } else {
      int j = 0;
      for (var elem in entry_list) {
        if (elem.id != f.id) {
          j++;
        }
      }
      if (j == entry_list.length) {
        entry_list.add(f);
      }
    }
  }
  print(entry_list.length);
  print(entry_list);
  List<entry> reversedList = entry_list.reversed.toList();
  return ListView.builder(
    itemCount: entry_list.length, // Replace with your data list length
    itemBuilder: (BuildContext context, int index) {
      //print(index);
      return reversedList[index];
    },
  );
}

Future<void> updateDatabase(
    int n, String s1, String s2, DateTime period) async {
  Purchase k = Purchase(n, s1, period, s2);
  await k.save();
}
