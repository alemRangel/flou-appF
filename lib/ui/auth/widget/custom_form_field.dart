import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String hintText;
  final bool obscureText;

  CustomFormField({
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.blue,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
