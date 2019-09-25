import 'package:ai_lab1/appbar.dart';
import 'package:ai_lab1/details.dart';
import 'package:ai_lab1/model/details.dart';
import 'package:ai_lab1/model/solver.dart';
import 'package:ai_lab1/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Lab1',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => DetailsPage(ModalRoute.of(context).settings.arguments)
      }
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Solver _solver = Solver();
  /* Таймер */
  Stopwatch _stopwatch = Stopwatch();
  Details _details = Details();
  bool _isChanged = true;

  callback(bool isChanged) {
    setState(() {
      _isChanged = isChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(callback, _isChanged),
      body: Stack(
        children: <Widget>[
          GridView.builder(
            itemCount: _solver.field.getState().length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return CustomGridTile(_solver.field.getState()[index]);
            }
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: _details);
            }
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0,
        closeManually: true,
        children: [
          SpeedDialChild(
            label: 'Заново',
            child: Icon(Icons.refresh),
            onTap: () {
              setState(() {
                CustomGridTile.tileColor = CustomGridTile.BEGIN;
                _solver.field.initState();
                _solver.initSolver();
                _stopwatch.reset();
              });
            }
          ),
          SpeedDialChild(
            label: 'Полное решение',
            child: Icon(Icons.accessible_forward),
            onTap: () {
              setState(() {
                bool solve;
                if (_isChanged) {
                  _stopwatch.start();
                  solve = _solver.solveBFS();
                  _stopwatch.stop();
                  _details.time = _stopwatch.elapsedMilliseconds;
                  _details.depth = _solver.depth;
                  _details.countNodes = _solver.countNodes;
                  _details.memory = _solver.memory;
                } else {
                  _stopwatch.start();
                  solve = _solver.solveDFID();
                  _stopwatch.stop();
                  _details.time = _stopwatch.elapsedMilliseconds;
                  _details.depth = _solver.depth;
                  _details.countNodes = _solver.countNodes;
                  _details.memory = _solver.memory;
                }
                if (solve) {
                  CustomGridTile.tileColor = CustomGridTile.END;
                  showModalBottomSheet(
                    context: context,
                    builder: (buildContext) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.check),
                            Text(
                              'Успех',
                              style: TextStyle(
                                fontSize: 20.0
                              ),
                            )
                          ]
                        )
                      );
                    },
                  );
                }
              });
            }
          ),
          SpeedDialChild(
            label: 'Пошагово',
            child: Icon(Icons.accessible),
            onTap: () {
              setState(() {
                bool solve;
                if (_isChanged) {
                  solve = _solver.stepByStepBFS();
                } else {
                  solve = _solver.stepByStepDFID();
                }
                if (solve) {
                  CustomGridTile.tileColor = CustomGridTile.END;
                  showModalBottomSheet(
                    context: context,
                    builder: (buildContext) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.check),
                            Text(
                              'Успех',
                              style: TextStyle(
                                fontSize: 20.0
                              ),
                            )
                          ]
                        )
                      );
                    },
                  );
                }
              });
            }
          )
        ]
      ),
    );
  }
}