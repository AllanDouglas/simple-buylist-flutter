import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/bloc/list/list_bloc.dart';
import 'package:list/screen/all_products_screen.dart';
import 'bloc/product/product_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: MaterialApp(
        title: 'Lista de Compras',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AllProducts(),
      ),
      providers: <BlocProvider>[
        BlocProvider<ProductBloc>(
          builder: (BuildContext context) => ProductBloc(),
        ),
        BlocProvider<ListBloc>(
          builder: (BuildContext context) => ListBloc(),
        )
      ],
    );
  }
}
