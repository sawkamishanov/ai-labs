import 'dart:collection';
import 'package:ai_lab1/model/field.dart';
import 'package:ai_lab1/tile.dart';

class Solver {
  Field field = Field.initState();
  /*
    Поиск с обходом в ширину
   */
  Map<String, bool> visitedBFS;
  Map<String, bool> visitedDFID;
  Queue<Field> queueBFS;
  Queue<Field> stackDFID;
  int limitDFID;

  /* Вспомогательные данные */
  int _depth;
  int _countNodes;
  double _memory;
  final int _sizeSymbol = 144;

  Solver() {
    initSolver();
  }

  initSolver() {
    visitedBFS = Map<String, bool>();
    visitedDFID = Map<String, bool>();
    queueBFS = Queue<Field>();
    stackDFID = Queue<Field>();
    queueBFS.add(field);
    stackDFID.addLast(field);
    visitedBFS[field.toString()] = true;
    visitedDFID[field.toString()] = true;
    limitDFID = 0;
    _depth = 0;
    _countNodes = 0;
    _memory = 0;
  }

  /*
    Поиск в ширину
   */

  bool solveBFS() {
    while (queueBFS.isNotEmpty) {
      Field temp = queueBFS.removeFirst();
      ++_countNodes;
      if (temp.isEnd(temp.getState())) {
        field.setState(temp.getState());
        _depth = temp.getDepth();
        return true;
      }
      for (int i = 0; i < Action.values.length; ++i) {
        if (temp.checkNewState(Action.values[i])) {
          Field child = Field(temp.getRealState());
          child.toNewState(Action.values[i]);
          if (visitedBFS[child.toString()] == false || visitedBFS[child.toString()] == null) {
            queueBFS.add(child);
            child.setDepth(temp.getDepth() + 1);
            visitedBFS[child.toString()] = true;
          }
        }
      }
    }
    return false;
  }

  bool stepByStepBFS() {
    if (queueBFS.isNotEmpty) {
      Field temp = queueBFS.removeFirst();
      field.setState(temp.getState());
      if (temp.isEnd(temp.getState())) {
        return true;
      }
      for (int i = 0; i < Action.values.length; ++i) {
        if (temp.checkNewState(Action.values[i])) {
          Field child = Field(temp.getRealState());
          child.toNewState(Action.values[i]);
          if (visitedBFS[child.toString()] == false || visitedBFS[child.toString()] == null) {
            queueBFS.add(child);
            child.setDepth(temp.getDepth() + 1);
            visitedBFS[child.toString()] = true;
          }
        }
      }
    }
    return false;
  }

  /*
    Поиск с ограничением глубины
   */

  bool solveDLS(int limit) {
    while (stackDFID.isNotEmpty) {
      Field temp = stackDFID.removeLast();
      ++_countNodes;
      if (temp.getDepth() < limit) {
        if (temp.isEnd(temp.getState())) {
          field.setState(temp.getState());
          _depth = temp.getDepth();
          return true;
        }
        for (int i = 0; i < Action.values.length; ++i) {
          if (temp.checkNewState(Action.values[i])) {
            Field child = Field(temp.getRealState());
            child.toNewState(Action.values[i]);
            if (visitedDFID[child.toString()] == false || visitedDFID[child.toString()] == null) {
              stackDFID.addLast(child);
              child.setDepth(temp.getDepth() + 1);
              visitedDFID[child.toString()] = true;
            }
          }
        }
      }
    }
    return false;
  }

  /*
    Поиск с итеративным углублением
   */

  bool solveDFID() {
    bool check = false;
    for (int i = 0; !check; ++i) {
      if (stackDFID.isEmpty) {
        visitedDFID = Map<String, bool>();
        stackDFID = Queue<Field>();
        stackDFID.addLast(field);
        visitedDFID[field.toString()] = true;
      }
      check = solveDLS(i);
      if (check) {
        return true;
      }
    }
    return false;
  }

  bool stepByStepDFID() {
    if (stackDFID.isEmpty) {
        visitedDFID = Map<String, bool>();
        stackDFID = Queue<Field>();
        stackDFID.addLast(field);
        visitedDFID[field.toString()] = true;
    }
    if (stackDFID.isNotEmpty) {
      Field temp = stackDFID.removeLast();
      if (temp.getDepth() < limitDFID) {
        field.setState(temp.getState());
        if (temp.isEnd(temp.getState())) {
          return true;
        }
        for (int i = 0; i < Action.values.length; ++i) {
          if (temp.checkNewState(Action.values[i])) {
            Field child = Field(temp.getRealState());
            child.toNewState(Action.values[i]);
            if (visitedDFID[child.toString()] == false || visitedDFID[child.toString()] == null) {
              stackDFID.addLast(child);
              child.setDepth(temp.getDepth() + 1);
              visitedDFID[child.toString()] = true;
            }
          }
        }
      }
      ++limitDFID;
    }
    return false;
  }

  int get depth => _depth;
  int get countNodes => _countNodes;
  double get memory {
    return _memory = (_sizeSymbol*_countNodes)/(1024*1024);
  }
}