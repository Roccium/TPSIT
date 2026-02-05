import 'package:flutter/widgets.dart';
import 'model.dart';

class TodoListNotifier with ChangeNotifier {
  final _container = <Contenitore>[];

  int get length_c => _container.length;

  void addContenitore() {
    _container.add(
      Contenitore(
        argomento: 'Contenitore ${_container.length + 1}',
        colore: randomColor(),
      ),
    );
    notifyListeners();
  }

  void addTodoToContenitore(Contenitore contenitore, String name) {
    contenitore.todos.add(Todo(name: name, checked: false));
    notifyListeners();
  }

  void changeTodo(Todo todo) {
    todo.checked = !todo.checked;
    notifyListeners();
  }

  void deleteTodo(Contenitore contenitore, Todo todo) {
    contenitore.todos.remove(todo);
    notifyListeners();
  }

  Contenitore getContainer(int i) => _container[i];
}
