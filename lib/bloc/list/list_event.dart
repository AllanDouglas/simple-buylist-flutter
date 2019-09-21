import 'package:equatable/equatable.dart';
import 'package:list/models/list.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListEvent extends Equatable {
  ListEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadListsEvent extends ListEvent {}

class AddListEvent extends ListEvent {
  final ProductList list;
  AddListEvent(this.list) : super([list]);
}

class UpdateListEvent extends ListEvent {
  final ProductList list;
  UpdateListEvent(this.list) : super([list]);
}

class DeleteListEvent extends ListEvent {
  final ProductList list;
  DeleteListEvent(this.list) : super([list]);
}
