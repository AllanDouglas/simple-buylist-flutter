import 'package:list/models/product.dart';

class ProductList {
  List<Product> products;
  int id;

  ProductList(this.products);

  Map<String, dynamic> toMap() {
    return {"products": products.map((product) => product.toMap())};
  }

  static ProductList fromMap(Map<String, dynamic> map) {
    var products = (map["products"] as List).toList();

    return ProductList(products.map((prod) => Product.fromMap(prod)).toList());
  }
}
