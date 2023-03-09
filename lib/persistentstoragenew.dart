import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

import 'main.dart';

class Purchase {
  Random random = new Random();
  int? id;
  final int amount;
  final String purchase;
  String? purchasetype;
  Purchase(this.amount, this.purchase, [this.purchasetype, this.id]) {
    id ??= random.nextInt(100000);
    purchasetype ??= "potato";
  }
  Future<void> save() async {
    final List<String>? items = prefs!.getStringList('allitems');
    items!.add("$this.id $this.amount $this.purchase $this.purchasetype");
    await prefs!.setStringList("allitems", items);
  }
}

List<String> GetAll() {
  final List<String>? items = prefs!.getStringList('allitems');
  return items!;
}

List<Purchase> getallPurchases() {
  List<Purchase> end = [];
  var first = GetAll();
  for (String item in first) {
    List x = item.split(" ");
    Purchase p = Purchase(x[1], x[2], x[3], x[0]);
    end.add(p);
  }
  return end;
}
