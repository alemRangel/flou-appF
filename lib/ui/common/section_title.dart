import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String label;

  SectionTitle({this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 10.0,
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
          letterSpacing: 2.0,
          color: Colors.black.withOpacity(0.75),
        ),
      ),
    );
  }
}
