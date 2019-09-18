import 'package:ai_lab1/model/DFS.dart';
import 'package:ai_lab1/model/field.dart' as field;
import 'package:ai_lab1/tile.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Lab1',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DFS _dfs = DFS();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Метод слепого поиска')
      ),
      body: GridView.builder(
        itemCount: _dfs.field.getState().length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return CustomGridTile(_dfs.field.getState()[index]);
        }
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.accessible_forward),
            onPressed: () {
              setState(() {
                _dfs.solveBFS();
              });
            }
          ),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _dfs.field.setState(['6', '2', '8', '4', '1', '7', '5', '3', '']);
              });
            }
          )
        ],
      )
    );
  }
}
