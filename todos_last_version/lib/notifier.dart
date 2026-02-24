import 'package:flutter/widgets.dart';
import 'model.dart';
import 'Databasecontroller.dart';
class TodoListNotifier with ChangeNotifier {
  var identifiar=0;
  final _container = <Contenitore>[];
  final _database = Databasecontroller.istanza;
  int get length_c => _container.length;


  void firstQuery()async{
    List<Map<String, dynamic>> result= await _database.getAll();
    
    int highC = 0;
    for (var i = 0; i < result.length; i++) {
      if (highC < (result[i]["containerdiappartenenza"] as int)) {
        highC = (result[i]["containerdiappartenenza"] as int);
        print(highC);
      }
    }
    for (var i = 0; i <= highC; i++) {
      var idC =addContenitore();
      for (var element in result) {
        
        if (element["containerdiappartenenza"] as int == i) {
        Todo t = Todo(id:element["id"],name: element["contenuto"], checked: (element["statuschecked"] == 0)? false:true, contid: _container[idC-1].id);
      _container[idC-1].todos.add(t);
      notifyListeners();
        }

    }
    }
  }


  int calcid(int i){
    identifiar = identifiar+1;
    return i++;
  }


  int addContenitore() {
    
    _container.add(
      Contenitore(
        id: calcid(identifiar),
        argomento: 'Contenitore ${_container.length + 1}',
        colore: randomColor(),
      ),
    );
    notifyListeners();
    return identifiar;
  }

  void addTodoToContenitore(Contenitore contenitore, String name,bool check) {
    Todo t = Todo(name: name, checked: check, contid: contenitore.id);
    contenitore.todos.add(t);
    _database.addTask(t);
    notifyListeners();
  }
  
  void changeTodo(Todo todo) {
    todo.checked = !todo.checked;
    print(todo.id);
    _database.modifytask(todo);
    notifyListeners();
  }

  void deleteTodo(Contenitore contenitore, Todo todo) {
    contenitore.todos.remove(todo);
    _database.deleteTask(todo);
    notifyListeners();
  }

  Contenitore getContainer(int i) => _container[i];
}
