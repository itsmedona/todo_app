import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/model/NoteModel/NoteModel.dart';

class DatabaseNotes {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE notes(id INTEGER PRIMARY KEY,title TEXT,description TEXT,date TEXT,color INTEGER)');
      },
    );
  }

  Future<void> insertNote(NoteModel note) async {
    final Database db = await database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteModel>> getNotes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return NoteModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        color: maps[i]['color'],
      );
    });
  }
}
