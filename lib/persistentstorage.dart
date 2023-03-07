import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class Purchase {
  Random random = new Random();
  Future<Database>? database;
  int? id;
  final int amount;
  final String purchase;
  final String purchasetype;
  Purchase(this.amount, this.purchase, this.purchasetype, [this.id]) {
    id ??= random.nextInt(100000);
    if (database == null) {
      createTable();
    }
    initializeinDatabase(this);
  }
  @override
  String toString() {
    return 'Dog{id: $id, amount: $amount, purchase: $purchase, purchasetype: $purchasetype}';
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

  Future<List<Purchase>> getallPurchases() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('Purchases');
    return List.generate(maps.length, (i) {
      return Purchase(maps[i]['amount'], maps[i]['purchase'],
          maps[i]['purchasetype'], maps[i]['id']);
    });
  }

  Future<void> createTable() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'purchasedatabase.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Purchases(id INTEGER PRIMARY KEY, purchase TEXT purchasetype TEXT, amount INTEGER)',
        );
      },
      version: 1,
    );
  }
}
