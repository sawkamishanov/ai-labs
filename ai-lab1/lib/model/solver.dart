import 'dart:collection';
import 'package:ai_lab1/model/field.dart';

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
      print(temp);
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


  // bool solveDLS() {
    
  //   print(field.getDepth());
  //   if (field.getDepth() < _limit) {
  //     visitedDLS[field.toString()] = true;
  //     if (field.isEnd(field.getState())) {
  //       return true;
  //     }
  //     for (int i = 0; i < Action.values.length; ++i) {
  //       if (field.checkNewState(Action.values[i])) {
  //         field.setDepth(field.getDepth() + 1);
  //         field.toNewState(Action.values[i]);
  //         if (visitedDLS[field.toString()] == false || visitedDLS[field.toString()] == null) {
  //           visitedDLS[field.toString()] = true;
  //           if (solveDLS()) {
  //             return true;
  //           }
  //         }
  //       }
  //     }
  //   }
  //   return false;
  // }

  bool solveDLS() {
    Map<String, bool> visited = Map<String, bool>();
    Queue<Field> stack = Queue<Field>();
    int limit = 300000;

    stack.addLast(field);
    visited[field.toString()] = true;
    while (stack.isNotEmpty) {
      Field temp = stack.removeLast();
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
            visited[child.toString()] = true;
          }
        }
      }
    }
    return false;
  }

  // bool recursiveDLS(Field temp, Map<String, bool> visited, int limit) {
  //   if (temp.isEnd(temp.getState())) {
  //       field.setState(temp.getState());
  //       return true;
  //   }
  //   if (limit == 0) {
  //     return false;
  //   }
  //   visited[temp.toString()] = true;
  //   print(temp.getState());
  //   for (int i = 0; i < Action.values.length; ++i) {
  //     if (temp.checkNewState(Action.values[i])) {
  //       Field child = Field(temp.getRealState());
  //       child.toNewState(Action.values[i]);
  //       if (visited[child.toString()] == false || visited[child.toString()] == null) {
  //         if (recursiveDLS(child, visited, limit - 1)) {
  //           return true;
  //         }
  //       }
  //     }
  //   }
  //   return false;
  // }
}