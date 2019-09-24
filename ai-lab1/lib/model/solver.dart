import 'dart:collection';
import 'package:ai_lab1/model/field.dart';
import 'package:ai_lab1/tile.dart';

class Solver {
  Field field = Field.initState();

  /*
    Поиск с обходом в ширину
   */

  bool solveBFS() {
    Map<String, bool> visited = Map<String, bool>();
    Queue<Field> queue = Queue<Field>();

    queue.add(field);
    visited[field.toString()] = true;
    while (queue.isNotEmpty) {
      Field temp = queue.removeFirst();
      if (temp.isEnd(temp.getState())) {
        field.setState(temp.getState());
        return true;
      }
      for (int i = 0; i < Action.values.length; ++i) {
        if (temp.checkNewState(Action.values[i])) {
          Field child = Field(temp.getRealState());
          child.toNewState(Action.values[i]);
          if (visited[child.toString()] == false || visited[child.toString()] == null) {
            queue.add(child);
            visited[child.toString()] = true;
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
    Map<String, bool> visited = Map<String, bool>();
    Queue<Field> stack = Queue<Field>();

    stack.addLast(field);
    visited[field.toString()] = true;
    while (stack.isNotEmpty) {
      Field temp = stack.removeLast();
      if (temp.getDepth() < limit) {
        if (temp.isEnd(temp.getState())) {
          field.setState(temp.getState());
          return true;
        }
        for (int i = 0; i < Action.values.length; ++i) {
          if (temp.checkNewState(Action.values[i])) {
            Field child = Field(temp.getRealState());
            child.toNewState(Action.values[i]);
            if (visited[child.toString()] == false || visited[child.toString()] == null) {
              stack.addLast(child);
              child.setDepth(temp.getDepth() + 1);
              visited[child.toString()] = true;
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
      check = solveDLS(i);
      if (check) {
        return true;
      }
    }
    return false;
  }
}