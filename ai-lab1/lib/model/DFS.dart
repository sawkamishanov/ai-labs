import 'dart:collection';

import 'package:ai_lab1/model/field.dart' as data;
import 'package:ai_lab1/model/node.dart';

class DFS {
  data.Field field = data.Field(['6', '2', '8', '4', '1', '7', '5', '3', '']);
  // setNextState() {
  //   var result = field.toNewState(data.Action.Right);
  //   if (result == null) {
  //     result = field.toNewState(data.Action.Left);
  //     if (result == null) {
  //       result = field.toNewState(data.Action.Up);
  //       if (result == null) {
  //         result = field.toNewState(data.Action.Down);
  //       }
  //     }
  //   }
  // }

  // bool result;
  // bool solveDFS(String position) {
  //   if (visited[position] == null) {
  //     visited[position] = false;
  //   }
  //   print(position);
  //   if (field.isEnd()) {
  //     return true;
  //   } else {
  //     if (visited[position]) {
  //       return false;
  //     } else {
  //       visited[position] = true;
  //       result = solveDFS(field.toNewState(data.Action.Right).toString());
  //       if (result == null) {
  //         result = solveDFS(field.toNewState(data.Action.Left).toString());
  //       }
  //       if (result == null) {
  //         result = solveDFS(field.toNewState(data.Action.Up).toString());
  //       }
  //       if (result == null) {
  //         result = solveDFS(field.toNewState(data.Action.Down).toString());
  //       }
  //       visited[field.toString()] = false;
  //     }
  //   }
  //   return result;
  // }

  Map<String, bool> visited = Map<String, bool>();

  bool solveBFS() {
    Queue<data.Field> queue = Queue<data.Field>();
    queue.add(field);
    visited[field.toString()] = true;
    while (queue.isNotEmpty) {
      data.Field temp = queue.removeFirst();
      print("Parent: ");
      print(temp.getState());
      if (temp.isEnd(temp.getState())) {
        field.setState(temp.getState());
        return true;
      }
      for (int i = 0; i < data.Action.values.length; ++i) {
        if (temp.checkNewState(data.Action.values[i])) {
          data.Field child = data.Field(temp.getRealState());
          child.toNewState(data.Action.values[i]);
          print("Child $i: ");
          print(child.getState());
          if (visited[child.toString()] == false || visited[child.toString()] == null) {
            queue.add(child);
            visited[child.toString()] = true;
          }
        }
      }
    }
    print(visited);
    return false;
  }
}