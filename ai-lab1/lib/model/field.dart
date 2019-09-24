import 'package:collection/collection.dart';

enum Action {
  Right, Left, Up, Down
}

class Field {

  /* Варианты перемещения по полю */

  final _RIGHT = 1;
  final _LEFT = -1;
  final _UP = -3;
  final _DOWN = 3;

  /*Начальное и конечное состояние */

  List<String> _state;
  final List<String> _endState = ['1', '2', '3', '4', '5', '6', '7', '8', ''];
  int _depth;
  /*
    Переход в новое состояние: головоломка релизована в виде одномерного массива,
    поэтому передвижение фишек осуществляется след. образом:
    Left: -1 по индексу в массиве;
    Right: +1 по индексу в массиве;
    Down: +3 по индексу в массиве (размерность матрицы);
    Up: -3 по индексу в массиве;
   */

  Field(this._state);

  Field.initState() {
    _state = ['8', '7', '3', '1', '5', '6', '4', '2', ''];
    _depth = 0;
  }

  void initState() {
    _state = ['8', '7', '3', '1', '5', '6', '4', '2', ''];
    _depth = 0;
  }

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
        swap = index + _RIGHT;
        break;
      case Action.Left:
        swap = index + _LEFT;
        break;
      case Action.Up:
        swap = index + _UP;
        break;
      case Action.Down:
        swap = index + _DOWN;
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
        swap = index + _RIGHT;
        break;
      case Action.Left:
        swap = index + _LEFT;
        break;
      case Action.Up:
        swap = index + _UP;
        break;
      case Action.Down:
        swap = index + _DOWN;
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

  List<String> getState() => _state;

  setState(List<String> state) => _state = state;

  List<String> getRealState() {
    List<String> list = List<String>();
    list.addAll(_state);
    return list;
  }

  setDepth(int depth) => _depth = depth;

  int getDepth() => _depth;

  @override
  String toString() {
    return _state.toString();
  }
}