import 'package:flutter/widgets.dart';

class Product {
  int id;
  bool caught = false;

  final String name;

  Product({@required this.name});

  Map<String, dynamic> toMap() {
    return {"name": name, "caught" : this.caught };
  }

  static Product fromMap(Map<String, dynamic> map) {
    final prod = Product(name: map["name"]);
    prod.caught = map["caught"] ?? false;
    return prod;
  }
}
