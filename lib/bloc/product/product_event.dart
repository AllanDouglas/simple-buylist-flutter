import 'package:equatable/equatable.dart';
import 'package:list/models/product.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductEvent extends Equatable {
  ProductEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {

  final Product product;

  AddProductEvent(this.product) : super([product]);

}

class DeleteProductEvent extends ProductEvent {
  final Product product;

  DeleteProductEvent(this.product) : super([product]);
}
