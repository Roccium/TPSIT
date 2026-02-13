import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/model.dart';

class Databasecontroller {
  static Database? _db;
  static final Databasecontroller istanza  = Databasecontroller._constructor();
  final String todo = "todo";
  final String id = "id";
  final String contenuto = "contenuto";
  final String statuschecked = "statuschecked";
  final String containerdiappartenenza = "containerdiappartenenza";
  Databasecontroller._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }else{
      _db = await getDatabase();
      return _db!;
    }
  }

  Future<Database> getDatabase() async{
    final middatabasepath = await getDatabasesPath();
    final fulldatabase = join(middatabasepath,"lite_db.db");
    final database = await openDatabase(
      fulldatabase,
      onCreate: (db, version) => {
          db.execute('''
          CREATE TABLE $todo(
          $id INTEGER PRIMARY KEY,
          $contenuto TEXT NOT NULL
          $statuschecked INTEGER NOT NULL
          $containerdiappartenenza INTEGER NOT NULL
          )
          ''')
        },
      );
      return database;
  }
  void modifytask(Todo todoxupdate) async{
    final db = await database;
     Map<String, Object?> row = {
      contenuto  : todoxupdate.name,
      statuschecked : ((todoxupdate.checked==false) ? 0 : 1),
      containerdiappartenenza : todoxupdate
    };
    await db.update(
    todo, 
    row,
    where: '${id} = ?',
    whereArgs: [todoxupdate.id],
    );
  }
  void addTask(String contenuti, int contenitore) async{
      final db = await database;
      await db.insert(todo, 
      { 
      contenuto:contenuti,
      statuschecked:0,
      containerdiappartenenza:contenitore
      }
        );
  }

}