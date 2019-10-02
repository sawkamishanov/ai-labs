
import 'package:ai_lab2/model/details.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Details _details;

  DetailsPage(this._details);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Подробности'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Text(
              'Глубина: ${_details.depth}',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          ),
          Card(
            child: Text(
              'Пройдено узлов: ${_details.countNodes}',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          ),
          Card(
            child: Text(
              'Время выполнения: ${_details.time} мс',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          ),
          Card(
            child: Text(
              'Память: ${_details.memory != null ? _details.memory.toStringAsFixed(2): null } МБ',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          )
        ],
      )
    );
  }
}