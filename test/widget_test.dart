// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart' as prefix0;
import 'package:list/data/app_database.dart';
import 'package:sembast/sembast.dart';

void main() {
  test("open db connection", () async {
    final appDB = AppDatabase.instance;

    final db = await appDB.database;

    expect(true, db.path.contains("demo"));
  });

  test("save product", () {
    fail("no code");
  });
}
