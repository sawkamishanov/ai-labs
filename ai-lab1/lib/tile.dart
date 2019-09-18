import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  final String _text;

  CustomGridTile(this._text);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 30.0
            ),
          ),
        ),
      color: Colors.deepPurple[200]
    );
  }
}
