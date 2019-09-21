import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:list/data/product_dao.dart';
import '../bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final _productsDao = ProductDao();

  @override
  ProductState get initialState => ProductsLoading();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is LoadProductsEvent) {
      yield ProductsLoading();
      yield* _reloadProducts();
    } else if (event is AddProductEvent) {
      await _productsDao.insert(event.product);
      yield* _reloadProducts();
    } else if (event is DeleteProductEvent) {
      await _productsDao.delete(event.product);
      yield* _reloadProducts();
    }
  }

  Stream<ProductState> _reloadProducts() async* {
    final result = await _productsDao.getAll();
    yield ProductsLoaded(result);
  }
}
