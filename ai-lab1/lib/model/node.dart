import 'package:ai_lab1/model/field.dart';

class Node {
  Field _field;
  Action _action;
  

  Node (
    this._field,
    this._action
  );

  Field getField() => _field;
  setField(Field field) => this._field = field;

  Action getAction() => _action;
  setAction(Action action) => this._action = action;
}