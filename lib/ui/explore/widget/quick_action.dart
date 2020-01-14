import 'package:flutter/material.dart';

class QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTapped;

  QuickAction({
    @required this.icon,
    @required this.label,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RawMaterialButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(18.0),
          fillColor: Colors.grey[200],
          splashColor: Colors.blueGrey[200],
          highlightColor: Colors.blueGrey[200].withOpacity(0.3),
          elevation: 15.0,
          highlightElevation: 0.0,
          disabledElevation: 0.0,
          onPressed: onTapped,
          child: Icon(
            icon,
            size: 35.0,
            color: Colors.blueGrey[400],
          ),
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
        Text(
          label.toUpperCase(),
          style: TextStyle(fontSize: 12.0, letterSpacing: 2.0),
        ),
      ],
    );
  }
}
