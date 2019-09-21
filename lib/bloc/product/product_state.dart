import 'package:equatable/equatable.dart';
import 'package:list/models/product.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductState extends Equatable {
  ProductState([List props = const <dynamic>[]]) : super(props);
}

class InitialProductState extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  ProductsLoaded(this.products) : super([products]);
}
