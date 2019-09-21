import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:list/data/list_dao.dart';
import 'package:list/models/list.dart';
import '../bloc.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final _listDao = ListDao();
  @override
  ListState get initialState => ListLoading();

  @override
  Stream<ListState> mapEventToState(
    ListEvent event,
  ) async* {
    if (event is LoadListsEvent) {
      var result = await _listDao.getAll();

      if (result.length == 0) {
        await _listDao.insert(ProductList(List()));
        result = await _listDao.getAll();
      }
      yield ListLoaded(result[0]);
    } else if (event is AddListEvent) {
      await _listDao.insert(event.list);
      yield* _reloadList();
    } else if (event is UpdateListEvent) {
      await _listDao.update(event.list);
      yield* _reloadList();
    } else if (event is DeleteListEvent) {
      await _listDao.delete(event.list);
      yield* _reloadList();
    }
  }

  Stream<ListState> _reloadList() async* {
    final result = await _listDao.getAll();
    yield ListLoaded(result[0]);
  }
}
