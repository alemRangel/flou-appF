import 'dart:async';

import 'package:flutter/material.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class FullScreenDialogPage extends StatefulWidget {
  final String title;
  final String label;
  final String actionLabel;
  final Function onValueSubmitted;

  FullScreenDialogPage({
    @required this.title,
    @required this.label,
    @required this.actionLabel,
    @required this.onValueSubmitted,
  });

  @override
  FullScreenDialogPageState createState() => FullScreenDialogPageState();
}

class FullScreenDialogPageState extends State<FullScreenDialogPage> {
  bool _saveNeeded = false;
  String _fieldValue;

  Future<bool> _onWillPop() async {
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('¿Descartar?', style: dialogTextStyle),
              actions: <Widget>[
                FlatButton(
                  child: const Text('CANCELAR'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: const Text('DESCARTAR'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.actionLabel,
              style: theme.textTheme.body1.copyWith(color: Colors.white),
            ),
            onPressed: () {
              widget.onValueSubmitted(_fieldValue);
              Navigator.pop(context, DismissDialogAction.save);
            },
          ),
        ],
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: InputDecoration(
                  labelText: widget.label,
                  filled: true,
                ),
                style: theme.textTheme.headline,
                onChanged: (String value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      _fieldValue = value;
                    }
                  });
                },
              ),
            ),
          ].map<Widget>((Widget child) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 96.0,
              child: child,
            );
          }).toList(),
        ),
      ),
    );
  }
}
