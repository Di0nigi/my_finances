import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

late Future<Database> database;

class Purchase {
  Random random = new Random();
  int? id;
  final int amount;
  final String purchase;
  String? purchasetype;
  Purchase(this.amount, this.purchase, [this.purchasetype, this.id]) {
    id ??= random.nextInt(100000);
    purchasetype ??= "potato";
    createTable();
    initializeinDatabase(this);
  }
  @override
  String toString() {
    return 'Purchase{id: $id, amount: $amount, purchase: $purchase, purchasetype: $purchasetype}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'purchase': purchase,
      'purchasetype': purchasetype,
      'amount': amount
    };
  }

  Future<void> initializeinDatabase(Purchase newpurchase) async {
    final db = await database;
    await db!.insert(
      'Purchases',
      newpurchase.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> createTable() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'purchasedatabase.db'),
      onCreate: (database, version) {
        return database.execute(
          'CREATE TABLE Purchases(id INTEGER PRIMARY KEY, purchase TEXT, purchasetype TEXT, amount INTEGER)',
        );
      },
      version: 1,
    );
  }
}

Future<List<Purchase>> getallPurchases() async {
  final db = await database;
  assert(db != null);
  final List<Map<String, dynamic>> maps = await db!.query('Purchases');
  return List.generate(maps.length, (i) {
    return Purchase(maps[i]['amount'], maps[i]['purchase'],
        maps[i]['purchasetype'], maps[i]['id']);
  });
}
