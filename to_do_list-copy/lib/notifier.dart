import 'package:flutter/widgets.dart';
import 'model.dart';
import 'Databasecontroller.dart';
class TodoListNotifier with ChangeNotifier {
  var identifiar=0;
  final _container = <Contenitore>[];
  final _database = Databasecontroller.istanza;
  int get length_c => _container.length;

  int calcid(int i){
    identifiar = identifiar+1;
    return i++;
  }
  void addContenitore() {
    
    _container.add(
      Contenitore(
        id: calcid(identifiar),
        argomento: 'Contenitore ${_container.length + 1}',
        colore: randomColor(),
      ),
    );
    notifyListeners();
  }

  void addTodoToContenitore(Contenitore contenitore, String name) {
    contenitore.todos.add(Todo(name: name, checked: false));
    _database.addTask(name,contenitore.id);
    notifyListeners();
  }

  void changeTodo(Todo todo) {
    todo.checked = !todo.checked;
    _database.modifytask(todo);
    notifyListeners();
  }

  void deleteTodo(Contenitore contenitore, Todo todo) {
    contenitore.todos.remove(todo);
    notifyListeners();
  }

  Contenitore getContainer(int i) => _container[i];
}
