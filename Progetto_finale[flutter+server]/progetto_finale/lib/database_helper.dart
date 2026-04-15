// lib/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models.dart';

class DatabaseHelper {
  // Singleton Pattern corretto
  static final DatabaseHelper istanza = DatabaseHelper._internal();
  factory DatabaseHelper() => istanza;
  DatabaseHelper._internal();

  static Database? _database;

  // Getter asincrono con gestione del null
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'armadio_v2.db');
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

  // --- METODI CRUD ---

  Future<int> insertCapo(Capo capo) async {
    final db = await database;
    return await db.insert('capi', capo.toMap());
  }

  Future<List<Capo>> getAllCapi() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('capi');
    // Generiamo la lista assicurandoci che non ci siano errori di mappatura
    return List.generate(maps.length, (i) => Capo.fromMap(maps[i]));
  }

  // Metodo mancante segnalato
  Future<int> deleteCapo(int id) async {
    final db = await database;
    return await db.delete(
      'capi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Metodo update (utile per la specifica PATCH/PUT del progetto)
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