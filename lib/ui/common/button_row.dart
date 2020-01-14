import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ButtonRowChild {
  Widget label;
  Function onPressed;

  ButtonRowChild({@required this.label, @required this.onPressed});
}

class ButtonRow extends StatelessWidget {
  final List<ButtonRowChild> children;

  ButtonRow({this.children});

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> buttons = children.map(_buildButton).toList();
    return Row(children: buttons.toList());
  }

  Widget _buildButton(ButtonRowChild child) {
    return Expanded(
      child: FlatButton(
        child: child.label,
        onPressed: child.onPressed,
        padding: EdgeInsets.symmetric(vertical: 24.0),
      ),
    );
  }
}
