import 'package:sqflite/sqflite.dart';

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
}
