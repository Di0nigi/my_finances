import 'package:my_finances/main.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:async' as asy;
import 'dart:math';
//import 'package:async/async.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class Purchase {
  Random random = new Random();
  int? id;
  final int amount;
  final String purchase;
  String? purchasetype;
  Purchase(this.amount, this.purchase, [this.purchasetype, this.id]) {
    id ??= random.nextInt(100000);
    purchasetype ??= "potato";
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

  asy.Future<void> initializeinDatabase(Purchase newpurchase) async {
    final db = await database;
    await db!.insert(
      'Purchases',
      newpurchase.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}

asy.Future<List<Purchase>> getallPurchases() async {
  final db = await database;
  assert(db != null);
  final List<Map<String, dynamic>> maps = await db!.query('Purchases');
  return List.generate(maps.length, (i) {
    return Purchase(maps[i]['amount'], maps[i]['purchase'],
        maps[i]['purchasetype'], maps[i]['id']);
  });
}

Future<sql.Database>? createTable() async {
  sql.Database database = await sql.openDatabase(
    join(await sql.getDatabasesPath(), 'purchasedatabase.db'),
    onCreate: (database, version) {
      return database.execute(
        'CREATE TABLE Purchases(id INTEGER PRIMARY KEY, purchase TEXT, purchasetype TEXT, amount INTEGER)',
      );
    },
    version: 1,
  );
  return database;
}
