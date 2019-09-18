import 'package:ai_lab1/model/node.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

enum Action {
  Right, Left, Up, Down
}

class Field {

  /* Варианта перемещение по полю */

  final RIGHT = 1;
  final LEFT = -1;
  final UP = -3;
  final DOWN = 3;

  /*Начальное и конечное состояние */

  List<String> _state;
  //List<String> _state = ['1', '2', '3', '4', '8', '0', '5', '6', ''];
  List<String> _endState = ['', '1', '2', '3', '4', '5', '6', '7', '8'];

  /*
    Переход в новое состояние: головоломка релизована в виде одномерного массива,
    поэтому передвижение фишек осуществляется след. образом:
    Left: -1 по индексу в массиве;
    Right: +1 по индексу в массиве;
    Down: +state.length по индексу в массиве;
    Up: -state.length по индексу в массиве;
   */

  Field(this._state);

  List<String> toNewState(Action action) {

    /*
      Поиск пустого значения на поле
     */

    int index = 0;
    for (; index < _state.length; ++index) {
      if (_state[index] == '') {
        break;
      }
    }

    int swap = 0;
    switch (action) {
      case Action.Right:
        swap = index + 1;
        break;
      case Action.Left:
        swap = index - 1;
        break;
      case Action.Up:
        swap = index - 3;
        break;
      case Action.Down:
        swap = index + 3;
        break;
      default:
    }

    if (swap >= _state.length || swap < 0) {
      return null;
    }
    if (action == Action.Right && (index + 1) % 3 == 0) {
      return null;
    }
    if (action == Action.Left && (index - 1) % 3 == 2) {
      return null;
    }

    String temp = _state[index];
    _state[index] = _state[swap];
    _state[swap] = temp;

    return _state;
  }

  bool checkNewState(Action action) {

    /*
      Поиск пустого значения на поле
     */

    int index = 0;
    for (; index < _state.length; ++index) {
      if (_state[index] == '') {
        break;
      }
    }

    int swap = 0;
    switch (action) {
      case Action.Right:
        swap = index + 1;
        break;
      case Action.Left:
        swap = index - 1;
        break;
      case Action.Up:
        swap = index - 3;
        break;
      case Action.Down:
        swap = index + 3;
        break;
      default:
    }

    if (swap >= _state.length || swap < 0) {
      return false;
    }
    if (action == Action.Right && (index + 1) % 3 == 0) {
      return false;
    }
    if (action == Action.Left && (index - 1) % 3 == 2) {
      return false;
    }

    return true;
  }

  /*
    Проверка достижения целевого состояния
   */
  bool isEnd(List<String> state) {
    return const ListEquality().equals(state, _endState);
  }

  List<String> getState() {
    return _state;
  }

  setState(List<String> state) => _state = state;

  List<String> getRealState() {
    List<String> list = List<String>();
    list.addAll(_state);
    return list;
  }

  @override
  String toString() {
    return _state.toString();
  }
}