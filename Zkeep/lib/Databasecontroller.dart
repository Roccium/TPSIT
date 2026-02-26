import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos_last_version/model.dart';
class Databasecontroller {
  static Database? _db;
  static final Databasecontroller istanza  = Databasecontroller._constructor();
  final String todo = "todo";
  final String id = "id";
  final String contenuto = "contenuto";
  final String statuschecked = "statuschecked";
  final String containerdiappartenenza = "containerdiappartenenza";
  Databasecontroller._constructor();

  Future<Database> database() async {
    (_db != null) ? _db! : _db = await getDatabase();
    return _db!;
    
  }

  Future<Database> getDatabase() async{
    final middatabasepath = await getDatabasesPath();
    final fulldatabase = join(middatabasepath,"lite_db.db");
    final database = await openDatabase(
      fulldatabase,
      version: 1,
      onCreate: (db, version) async {
          db.execute('''
          CREATE TABLE todo(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          contenuto TEXT NOT NULL,
          statuschecked INTEGER NOT NULL,
          containerdiappartenenza INTEGER NOT NULL
          )
          ''');
        },
      );
      return database;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
  final db = await database(); 
  final List<Map<String, dynamic>> result = await db.query(todo);
 
  return result;
}

  void modifytask(Todo todoxupdate) async{
    final db = await database();
     
    var check =(todoxupdate.checked == false) ? "0" : "1";
      
    await db.update(
    todo, 
    {statuschecked: check},
    where: '$id = ?',
    whereArgs: [todoxupdate.id],
    );
    
  }

  void addTask(Todo todoDaAggiugnere,) async{
      final db = await database();
      todoDaAggiugnere.id = await db.insert(todo, 
      { 
      contenuto:todoDaAggiugnere.name,
      statuschecked:0,
      containerdiappartenenza:todoDaAggiugnere.contid
      }
        );
  }

  void deleteTask(Todo todoDaCancellare) async{
    final db = await database();
    await  db.delete( todo,
    where: '$id = ?',
    whereArgs: [todoDaCancellare.id],
    );
  }

}
Future<void> deleteDatabase() async {
  final middatabasepath = await getDatabasesPath();
  final fulldatabase = join(middatabasepath, "lite_db.db");
  await databaseFactory.deleteDatabase(fulldatabase);
}