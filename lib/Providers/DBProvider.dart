import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database _database;
  Future<Database> initialize() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      return db.execute(
        """
        CREATE TABLE authState(id INTEGER PRIMARY KEY, userName TEXT, accessToken TEXT, refreshToken TEXT, expiresIn INTEGER);
        CREATE TABLE Goal(id INTEGER PRIMARY KEY, title TEXT, finished BOOLEAN, distance INTEGER, duration INTEGER,);
        CREATE TABLE Activity(id INTEGER PRIMARY KEY, userName TEXT, accessToken TEXT, refreshToken TEXT, expiresIn INTEGER);
        
        """,
      );
    });
    return _database;
  }

  Future<Database> getDatabase() async {
    if (_database != null)
      return _database;
    else
      return await initialize();
  }
}

class DBProvider {
  static DBHelper helper = new DBHelper();
}
