import 'package:list/data/app_database.dart';
import 'package:list/models/list.dart';
import 'package:sembast/sembast.dart';

class ListDao {
  static const String LIST_STORE_NAME = "_list_";

  final _productStore = intMapStoreFactory.store(LIST_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(ProductList list) async {
    await _productStore.add(await _db, list.toMap());
  }

  Future update(ProductList list) async {
    final finder = Finder(filter: Filter.byKey(list.id));
    await _productStore.update(await _db, list.toMap(), finder: finder);
  }

  Future delete(ProductList list) async {
    final finder = Finder(filter: Filter.byKey(list.id));
    await _productStore.delete(await _db, finder: finder);
  }

  Future<List<ProductList>> getAll() async {
    final records = await _productStore.find(await _db);
    return records.map((snapshot){
      final list = ProductList.fromMap(snapshot.value);
      list.id = snapshot.key;
      return list;
    }).toList();
  }
}
