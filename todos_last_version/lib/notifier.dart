import 'package:flutter/widgets.dart';
import 'model.dart';
import 'Databasecontroller.dart';
class TodoListNotifier with ChangeNotifier {
  var identifiar=0;
  final _container = <Contenitore>[];
  final _database = Databasecontroller.istanza;
  int get length_c => _container.length;


//funzione con query di darabasecontroller che crea una mappa di todos con una select * e aggiunge containter e todos
  void firstQuery()async{
    List<Map<String, dynamic>> result= await _database.getAll();
    var idC =addContenitore();
    int highC = 0;
    /*
    for (var i = 0; i < result.length; i++) {
      if (highC < (result[i]["containerdiappartenenza"] as int)) {
        highC = (result[i]["containerdiappartenenza"] as int);
        print(highC);
      }
    }*/
    print(idC);
    print("aAAAAAAAAAAAAAAA");
    for (var element in result) {
      addTodoToContenitore(_container[idC-1],element["contenuto"] as String,(element["statuschecked"] == 0)? false:true);
      //Todo t = Todo(name: element["contenuto"], checked: (element["statuschecked"] == 0)? false:true, contid: _container[idC-1].id);
      //_container[idC-1].todos.add(t);
      //notifyListeners();
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
    print(identifiar);
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
    _database.modifytask(todo);
    notifyListeners();
  }

  void deleteTodo(Contenitore contenitore, Todo todo) {
    contenitore.todos.remove(todo);
    notifyListeners();
  }

  Contenitore getContainer(int i) => _container[i];
}
