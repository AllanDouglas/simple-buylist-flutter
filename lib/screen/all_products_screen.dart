import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/bloc/bloc.dart';
import 'package:list/models/list.dart';

import 'package:list/models/product.dart';
import 'package:list/widgets/text_dialog_alert.dart';

import 'list_screen.dart';

class AllProducts extends StatefulWidget {
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  ProductBloc _productBloc;
  ListBloc _listBloc;

  ProductList _list;

  int _pagIndex = 0;

  void initState() {
    super.initState();

    _productBloc = BlocProvider.of<ProductBloc>(context);
    _listBloc = BlocProvider.of<ListBloc>(context);

    _listBloc.dispatch(LoadListsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      bloc: _listBloc,
      child: BlocProvider(
        builder: (context) => _productBloc,
        child: Scaffold(
          appBar: AppBar(
            title: (_pagIndex == 0) ? Text("Todos os Produtos") : Text("Lista de Compras"),
          ),
          body: (_pagIndex == 0) ? buildAllProducts() : _buildShopList(),
          bottomNavigationBar: _buildNavigationBar(),
          floatingActionButton:
              (_pagIndex == 0) ? _buildButtons() : Container(),
        ),
      ),
      listener: (BuildContext context, state) {
        if (state is ListLoaded && _list == null) {
          _list = state.list;
          _productBloc.dispatch(LoadProductsEvent());
        }
      },
    );
  }

  Widget _buildShopList() {
    return ProductLists();
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFieldAlertDialog(
              "Adicionar Produto",
              (product) => _productBloc
                  .dispatch(AddProductEvent(Product(name: product)))),
          SizedBox(
            height: 20.0,
          ),
          // FloatingActionButton(
          //   heroTag: "listBtn",
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => ProductLists()));
          //   },
          //   child: const Icon(Icons.library_books, size: 36.0),
          // ),
        ],
      ),
    );
  }

  Widget buildAllProducts() {
    return BlocBuilder(
      bloc: _productBloc,
      builder: (BuildContext context, ProductState state) {
        if (state is ProductsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductsLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final displayProduct = state.products[index];
              return ListTile(
                  title: Text(displayProduct.name),
                  trailing: _buildActionButtons(displayProduct));
            },
          );
        }

        return null;
      },
    );
  }

  Row _buildActionButtons(Product product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _addProductToListButton(product),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _productBloc.dispatch(DeleteProductEvent(product));
          },
        ),
        SizedBox(width: 20)
      ],
    );
  }

  Widget _addProductToListButton(Product product) {
    final prodWasAdded = _list.products.any((p) => p.name == product.name);

    if (prodWasAdded) {
      return Icon(Icons.check);
    }

    return IconButton(
      icon: Icon(Icons.add_circle_outline),
      onPressed: () {
        final newList = ProductList(_list.products);
        newList.id = _list.id;
        newList.products.add(product);

        _listBloc.dispatch(UpdateListEvent(newList));
        // _productBloc.dispatch(LoadProductsEvent());

        setState(() {
          this._list = newList;
        });
      },
    );
  }

  Widget _buildNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _pagIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (index) {
        setState(() {
          _pagIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.pages, color: Color.fromARGB(255, 0, 0, 0)),
          title: new Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list, color: Color.fromARGB(255, 0, 0, 0)),
          title: new Text(""),
        ),
      ],
    );
  }
}
