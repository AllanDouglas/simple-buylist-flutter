import 'package:equatable/equatable.dart';
import 'package:list/models/list.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListState extends Equatable {
  ListState([List props = const <dynamic>[]]) : super(props);
}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final ProductList list;

  ListLoaded(this.list) : super([list]);
}
