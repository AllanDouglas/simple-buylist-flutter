import 'package:flutter/material.dart';

class TextFieldAlertDialog extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  final Function(String) _okAction;
  final String _title;

  TextFieldAlertDialog(this._title, this._okAction);

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(this._title),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: _title),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  _okAction(_textFieldController.text);
                  _textFieldController.text = "";
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _displayDialog(context),
    );
  }
}
