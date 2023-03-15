import 'dart:async';
import 'dart:math';

import 'main.dart';

class Purchase {
  Random random = new Random();
  int? id;
  final DateTime dateTime_;
  final int amount;
  final String purchase;
  final String purchasetype;
  Purchase(this.amount, this.purchase, this.dateTime_, this.purchasetype,
      [this.id]) {
    id ??= random.nextInt(100000);
  }
  Future<void> save() async {
    final List<String>? items = prefs!.getStringList('allitems');
    String stringa =
        "${this.id} ${this.amount} ${this.purchase} ${this.purchasetype} ${dateTostring(this.dateTime_)}";
    items!.add(stringa);
    print(stringa);
    await prefs!.setStringList("allitems", items);
  }
}

Future<bool> delete(int id) async {
  bool worked = false;
  final List<String>? items = prefs!.getStringList('allitems');
  for (int i = 0; i < items!.length - 1; i++) {
    String Item = items[i];
    if (Item.split(" ")[0] == id.toString()) {
      print(Item.split(" ")[0]);
      worked = true;
      items.removeAt(i);
      break;
    }
  }
  if (worked) {
    await prefs!.setStringList("allitems", items);
  }
  return worked;
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
    Purchase p = Purchase(
        int.parse(x[1]), x[2], stringTodate(x[4]), x[3], int.parse(x[0]));
    end.add(p);
  }
  return end;
}

String dateTostring(DateTime d) {
  String s;
  s = "${d.day}.${d.month}.${d.year}";
  return s;
}

DateTime stringTodate(String s) {
  DateTime date;
  List<String> st = s.split(".");
  date = DateTime(int.parse(st[2]), int.parse(st[1]), int.parse(st[0]));
  return date;
}

Future<void> Datasave(String Sl) async {
  String stringe = "";
  final List<String>? Typesitems = prefsT!.getStringList('Purchasetypes');

  stringe += "${Sl} ";

  Typesitems!.add(stringe);
  print(stringe);
  await prefsT!.setStringList('Purchasetypes', Typesitems);
}

List<String> GetAllp() {
  final List<String>? items = prefsT!.getStringList('Purchasetypes');
  return items!;
}

List<String> getallPurchasesTypes() {
  List<String> types = [];
  var first = GetAllp();
  for (String item in first) {
    types.add(item);
  }

  return types;
}
