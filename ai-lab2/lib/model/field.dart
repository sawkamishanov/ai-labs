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

  List<String> state;
  final List<String> _endState = ['1', '2', '3', '4', '5', '6', '7', '8', ''];
  int cost;
  int heuristic;
  int func;

  /*
    Переход в новое состояние: головоломка релизована в виде одномерного массива,
    поэтому передвижение фишек осуществляется след. образом:
    Left: -1 по индексу в массиве;
    Right: +1 по индексу в массиве;
    Down: +3 по индексу в массиве (размерность матрицы);
    Up: -3 по индексу в массиве;
   */

  Field(this.state);

  Field.initState() {
    state = ['8', '7', '3', '1', '5', '6', '4', '2', ''];
    cost = 0;
    func = 0;
    heuristic = 0;
  }

  void initState() {
    state = ['8', '7', '3', '1', '5', '6', '4', '2', ''];
    cost = 0;
    func = 0;
    heuristic = 0;
  }

  List<String> toNewState(Action action) {

    /*
      Поиск пустого значения на поле
     */

    int index = 0;
    for (; index < state.length; ++index) {
      if (state[index] == '') {
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

    if (swap >= state.length || swap < 0) {
      return null;
    }
    if (action == Action.Right && (index + 1) % 3 == 0) {
      return null;
    }
    if (action == Action.Left && (index - 1) % 3 == 2) {
      return null;
    }

    String temp = state[index];
    state[index] = state[swap];
    state[swap] = temp;

    return state;
  }

  bool checkNewState(Action action) {

    /*
      Поиск пустого значения на поле
     */

    int index = 0;
    for (; index < state.length; ++index) {
      if (state[index] == '') {
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

    if (swap >= state.length || swap < 0) {
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

  List<String> getRealState() {
    List<String> list = List<String>();
    list.addAll(state);
    return list;
  }

  List<String> get endState => _endState;

  @override
  String toString() {
    return state.toString();
  }
}