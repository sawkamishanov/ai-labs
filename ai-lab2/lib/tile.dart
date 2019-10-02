import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  static const Color END = Color(0xFFC5E1A5);
  static const Color NEXT = Color(0xFFFFF59D);
  static const Color BEGIN = Color(0xFFB39DDB);
  
  static Color tileColor = BEGIN;
  final String _text;

  CustomGridTile(this._text);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 35.0
            ),
          ),
        ),
      color: tileColor
    );
  }
}
