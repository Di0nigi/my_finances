import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_finances/main.dart';
import 'package:my_finances/persistentstoragenew.dart';

/*class entry extends StatefulWidget {
  final double height;
  final double width;
  final int amount;
  final int? id;
  final String purchase;
  final String purchasetype;
  final String date;

  entry(
      {required this.height,
      required this.width,
      required this.amount,
      required this.id,
      required this.purchase,
      required this.purchasetype,
      required this.date});

  @override
  State<entry> createState() => entryState(
      height: height,
      width: width,
      amount: amount,
      id: id,
      purchase: purchase,
      purchasetype: purchasetype,
      date: date);
}*/

class entry extends StatelessWidget {
  final double height;
  final double width;
  final int amount;
  final int? id;
  final String purchase;
  final String purchasetype;
  final String date;

  entry(
      {required this.height,
      required this.width,
      required this.amount,
      required this.id,
      required this.purchase,
      required this.purchasetype,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: GestureDetector(
            onDoubleTap: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: Text(purchase.toUpperCase()),
                          actions: <Widget>[
                            Container(
                              height: 400,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 60),
                                            child: Text(
                                                "Amount: ${this.amount.toString()}")),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 60),
                                            child: Text(
                                                "Purchase: ${this.purchase}")),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 60),
                                            child: Text(
                                                "Category: ${this.purchasetype}")),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 60),
                                            child: Text("Date: ${this.date}")),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onDoubleTap: () {
                                            delete(this.id);
                                            print("done");
                                            global();
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 90,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
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
