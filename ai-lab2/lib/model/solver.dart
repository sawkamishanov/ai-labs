import 'dart:collection';
import 'package:ai_lab2/model/field.dart';


class Solver {
  Field field = Field.initState();
  List<Field> open;
  Map<String, bool> visited;

  /* Вспомогательные данные */

  int _countNodes;
  int _depth;
  double _memory;
  int _func;
  int _heuristic;
  final int _sizeSymbol = 144;

  Solver() {
    initSolver();
  }

  initSolver() {
    open = List<Field>();
    visited = Map<String, bool>();
    open.add(field);
    visited[field.toString()] = true;
    field.cost = 0;
    _countNodes = 0;
    _depth = 0;
    _memory = 0.0;
    _func = 0;
    _heuristic = 0;
  }

  /*
    Алгоритм A*
   */

  bool AStar(int Function(Field) h) {
    if (countNodes == 0) {
      field.func = h(field);
      field.heuristic = field.func;
    }
    while (open.isNotEmpty) {
      ++_countNodes;
      Field temp = getStateWitMinFunc(open);
      _func = temp.func;
      _heuristic = temp.heuristic;
      if (temp.isEnd(temp.state)) {
        _depth = temp.cost;
        field.state = temp.state;
        return true;
      }
      open.remove(temp);
      visited[temp.toString()] = true;
      for (int i = 0; i < Action.values.length; ++i) {
        if (temp.checkNewState(Action.values[i])) {
          Field child = Field(temp.getRealState());
          child.toNewState(Action.values[i]);
          child.cost = temp.cost + 1;
          child.heuristic = h(child);
          child.func = child.cost + child.heuristic;
          if (visited[child.toString()] == false || visited[child.toString()] == null) {
            open.add(child);
            visited[child.toString()] = true;
          }
        }
      }
    }
    return false;
  }

  bool stepByStepAStar(int Function(Field) h) {
    if (countNodes == 0) {
      field.func = h(field);
      field.heuristic = field.func;
    }
    if (open.isNotEmpty) {
      ++_countNodes;
      Field temp = getStateWitMinFunc(open);
      field.state = temp.state;
      _func = temp.func;
      _heuristic = temp.heuristic;
      if (temp.isEnd(temp.state)) {
        field.state = temp.state;
        return true;
      }
      open.remove(temp);
      visited[temp.toString()] = true;
      for (int i = 0; i < Action.values.length; ++i) {
        if (temp.checkNewState(Action.values[i])) {
          Field child = Field(temp.getRealState());
          child.toNewState(Action.values[i]);
          child.cost = temp.cost + 1;
          child.heuristic = h(child);
          child.func = child.cost + child.heuristic;
          if (visited[child.toString()] == false || visited[child.toString()] == null) {
            open.add(child);
            visited[child.toString()] = true;
          }
        }
      }
    }
    return false;
  }

  Field getStateWitMinFunc(List<Field> open) {
    Field result;
    int min = open[0].func;
    for (Field field in open) {
      if (field.func <= min) {
        min = field.func;
        result = field;
      }
    }
    return result;
  }

  /*
    Эвристика h1 - число фишек, стоящих не на своем месте
   */

  int h1(Field current) {
    int count = 0;
    for (int i = 0; i < current.state.length; ++i) {
      if (current.endState[i] != current.state[i]) {
        ++count;
      }
    }
    return count;
  }

  /*
    Эвристика h2 - суммарное по всем фишкам число шагов до целевого положения (манхэттенское расстояние)
   */

  int h2(Field current) {
    int result = 0;
    for (int i = 0; i < current.state.length; ++i) {
      for (int j = 0; j < current.endState.length; ++j) {
        if (current.state[i] != current.endState[j]) {
          continue;
        } else {
          Point x = getPoint(i);
          Point y = getPoint(j);
          result += ((x.a - y.a).abs() + (x.b - y.b).abs()).toInt();
          break;
        }
      }
    }
    return result;
  }

  Point getPoint(int index) {
    switch (index) {
      case 0:
        return Point(0, 0);
        break;
      case 1:
        return Point(0, 1);
        break;
      case 2:
        return Point(0, 2);
        break;
      case 3:
        return Point(1, 0);
        break;
      case 4:
        return Point(1, 1);
        break;
      case 5:
        return Point(1, 2);
        break;
      case 6:
        return Point(2, 0);
        break;
      case 7:
        return Point(2, 1);
        break;
      case 8:
        return Point(2, 2);
        break;
      default:
    }
    return null;
  }

  int get countNodes => _countNodes;
  int get depth => _depth;
  double get memory {
    return _memory = (_sizeSymbol*_countNodes)/(1024*1024);
  }
  int get func => _func;
  int get heuristic => _heuristic;
}

class Point {
  num a; num b;
  Point(this.a, this.b);
}