import 'dart:io';
import 'package:flutter/material.dart';

class entry extends StatelessWidget {
  final double height;
  final double width;
  final int amount;
  final int? id;

  entry(
      {required this.height,
      required this.width,
      required this.amount,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: GestureDetector(
            onDoubleTap: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text('New Entry'),
                          actions: <Widget>[
                            Container(
                              height: 400,
                              color: Color.fromARGB(255, 56, 215, 255),
                            )
                          ]));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                //padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                height: height,
                width: width,
                child: Center(
                  child: Text(
                    amount.toString(),
                    style: TextStyle(
                      letterSpacing: 0,
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))));
  }
}
