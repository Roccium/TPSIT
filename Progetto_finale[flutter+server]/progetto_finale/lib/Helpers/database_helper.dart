import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models.dart';

class DatabaseHelper {
  static final Map<String, DatabaseHelper> _stanze = {};
  final String nomeUtente;
  Database? _database;
  factory DatabaseHelper(String nomeUtente) {
    if (_stanze.containsKey(nomeUtente)) {
      return _stanze[nomeUtente]!;
    } else {
      final nuovaIstanza = DatabaseHelper._internal(nomeUtente);
      _stanze[nomeUtente] = nuovaIstanza;
      return nuovaIstanza;
    }
  }

  DatabaseHelper._internal(this.nomeUtente);

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'armadio_$nomeUtente.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE capi(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoria TEXT NOT NULL,
            imagePath TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertCapo(Capo capo) async {
    final db = await database;
    return await db.insert('capi', capo.toMap());
  }

  Future<List<Capo>> getAllCapi() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('capi');
    return List.generate(maps.length, (i) => Capo.fromMap(maps[i]));
  }


  Future<int> deleteCapo(int id) async {
    final db = await database;
    return await db.delete(
      'capi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
//manco lo uso questo
  Future<int> updateCapo(Capo capo) async {
    if (capo.id == null) return 0;
    final db = await database;
    return await db.update(
      'capi',
      capo.toMap(),
      where: 'id = ?',
      whereArgs: [capo.id],
    );
  }
}