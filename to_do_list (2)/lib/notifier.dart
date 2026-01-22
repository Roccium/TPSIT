import 'package:flutter/widgets.dart';

import 'model.dart';

class TodoListNotifier with ChangeNotifier {
  final _todos = <Todo>[];
  final _container = <Contenitore>[];
  int get length_t => _todos.length;
  int get length_c => _container.length;

  void addTodo(String name) {
    _todos.add(Todo(name: name, checked: false));
    notifyListeners();
  }

  void addContenitore(String name) {
    _container.add(Contenitore(argomenti: name));
    notifyListeners();
  }

  void changeTodo(Todo todo) {
    todo.checked = !todo.checked;
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  Todo getTodo(int i) => _todos[i];
  Contenitore getContainer(int i) => _container[i];
}
