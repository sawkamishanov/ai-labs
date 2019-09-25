
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  Function(bool) _callback;
  bool _isChanged;

  CustomAppBar(this._callback, this._isChanged);
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _title = 'Поиск в ширину';

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(_title),
        actions: <Widget>[
          Switch(
            value: widget._isChanged,
            onChanged: (bool value) {
              setState(() {
                widget._callback(value);
                if (value) {
                  _title = 'Поиск в ширину';
                } else {
                  _title = 'С итеративным углублением';
                }
              });
            }
          )
        ],
    );
  }
}