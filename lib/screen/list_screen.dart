import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/bloc/bloc.dart';
import 'package:list/models/list.dart';
import 'package:list/models/product.dart';

class ProductLists extends StatefulWidget {
  _ListState createState() => _ListState();
}

class _ListState extends State<ProductLists> {
  ListBloc _listBloc;

  ProductList _list;

  void initState() {
    super.initState();

    _listBloc = BlocProvider.of<ListBloc>(context);
    _listBloc.dispatch(LoadListsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(builder: (context) => ListBloc(), child: buildBody()
        //  Scaffold(
        //     appBar: AppBar(
        //       title: Text("Lista"),
        //     ),
        //     body: buildBody())
        );
  }

  Widget buildBody() {
    return BlocBuilder(
      bloc: _listBloc,
      builder: (BuildContext context, ListState state) {
        if (state is ListLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ListLoaded) {
          _list = state.list;
          return ListView.builder(
            itemCount: state.list.products.length,
            itemBuilder: (context, index) {
              final displayProduct = state.list.products[index];
              return ListTile(
                  title: Text(displayProduct.name),
                  trailing: _buildDeleteButton(displayProduct));
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Row _buildDeleteButton(Product product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[shoppingCartButton(product), deleteButton(product)],
    );
  }

  IconButton deleteButton(Product product) {
    return IconButton(
      icon: Icon(Icons.delete_outline),
      onPressed: () {
        final index = _list.products.indexWhere((p) => p.name == product.name);
        _list.products.removeAt(index);
        _listBloc.dispatch(UpdateListEvent(_list));
      },
    );
  }

  IconButton shoppingCartButton(Product product) {
    return IconButton(
      icon: product.caught
          ? Icon(
              Icons.shopping_cart,
              color: Colors.greenAccent,
            )
          : Icon(Icons.add_shopping_cart),
      onPressed: () {
        final prod = _list.products.firstWhere((p) => p.name == product.name);

        prod.caught = !prod.caught;

        _listBloc.dispatch(UpdateListEvent(_list));
      },
    );
  }
}
