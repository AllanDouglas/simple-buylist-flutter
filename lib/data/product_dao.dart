import 'package:list/data/app_database.dart';
import 'package:list/models/product.dart';
import 'package:sembast/sembast.dart';

class ProductDao {
  static const String PRODUCT_STORE_NAME = "_products_";

  final _productStore = intMapStoreFactory.store(PRODUCT_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Product product) async {
    await _productStore.add(await _db, product.toMap());
  }

  Future update(Product product) async {
    final finder = Finder(filter: Filter.byKey(product.id));
    await _productStore.update(await _db, product.toMap(), finder: finder);
  }

  Future delete(Product product) async {
    final finder = Finder(filter: Filter.byKey(product.id));
    await _productStore.delete(await _db, finder: finder);
  }

  Future<List<Product>> getAll() async {

    final records = await _productStore.find(await _db);
    return records.map((snapshot){
      final prod = Product.fromMap(snapshot.value);
      prod.id = snapshot.key;
      return prod;
    }).toList();
  }
}
