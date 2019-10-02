import 'package:ai_lab2/appbar.dart';
import 'package:ai_lab2/details.dart';
import 'package:ai_lab2/model/details.dart';
import 'package:ai_lab2/model/solver.dart';
import 'package:ai_lab2/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Lab2',
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
  Solver _solver;
  /* Таймер */
  Stopwatch _stopwatch;
  Details _details;
  bool _isChanged;

  callback(bool isChanged) {
    setState(() {
      _isChanged = isChanged;
    });
  }

  @override
  void initState() {
    super.initState();
    _isChanged = true;
    _solver = Solver();
    _stopwatch = Stopwatch();
    _details = Details();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(callback, _isChanged),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 400.0,
            child: Stack(
              children: <Widget>[
                GridView.builder(
                  itemCount: _solver.field.state.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomGridTile(_solver.field.state[index]);
                  }
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/details', arguments: _details);
                  }
                ),
              ],
            ),
          ),
          Card(
            child: Text(
              'f(x) = g(x) + h(x) = ${_details.func}',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
          ),
          Card(
            child: Text(
              'h(x) = ${_details.heuristic}',
              style: TextStyle(
                fontSize: 30.0
              ),
            ),
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
                _details.initDetails();
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
                  solve = _solver.AStar(_solver.h1);
                  _stopwatch.stop();
                  _details.time = _stopwatch.elapsedMilliseconds;
                  _details.depth = _solver.depth;
                  _details.countNodes = _solver.countNodes;
                  _details.memory = _solver.memory;
                  _details.func = _solver.func;
                  _details.heuristic = _solver.heuristic;
                } else {
                  _stopwatch.start();
                  solve = _solver.AStar(_solver.h2);
                  _stopwatch.stop();
                  _details.time = _stopwatch.elapsedMilliseconds;
                  _details.depth = _solver.depth;
                  _details.countNodes = _solver.countNodes;
                  _details.memory = _solver.memory;
                  _details.func = _solver.func;
                  _details.heuristic = _solver.heuristic;
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
                  solve = _solver.stepByStepAStar(_solver.h1);
                  _details.func = _solver.func;
                  _details.heuristic = _solver.heuristic;
                } else {
                  solve = _solver.stepByStepAStar(_solver.h2);
                  _details.func = _solver.func;
                  _details.heuristic = _solver.heuristic;
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