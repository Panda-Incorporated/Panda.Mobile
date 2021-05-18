import 'package:intl/intl.dart';
import 'package:panda/Models/Activity.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Models/Goal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database _database;
  Future<bool> databaseExists() => databaseFactory.databaseExists('app.db');
  Future<Database> initialize() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      return db.execute(
        """CREATE TABLE AuthState(id INTEGER PRIMARY KEY, userName TEXT, accessToken TEXT, refreshToken TEXT, expires DATETIME);
        CREATE TABLE Goal(id INTEGER PRIMARY KEY, title TEXT, distance DOUBLE, duration INTEGER);
        CREATE TABLE Activity(id INTEGER PRIMARY KEY, date DATETIME, distance DOUBLE, duration INTEGER, GoalId INTEGER);""",
      );
    });
    return _database;
  }

  Future<void> insertGoal(Goal goal) async {
    final Database db = await getDatabase();
    await db.insert('Goal', goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertActivity(Activity activity) async {
    final Database db = await getDatabase();
    await db.insert('Activity', activity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateAuthState(AuthState authState) async {
    final Database db = await getDatabase();
    if (authState.id == 0) {
      authState.id = 1;
      await db.insert(
        'AuthState',
        authState.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      var res = await db.update('AuthState', authState.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: "id = ?",
          whereArgs: [1]);
      if (res == 0) {
        authState.id = 1;
        await db.insert(
          'AuthState',
          authState.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
  }

  Future<List<Goal>> getGoals() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('Goal');
    return List.generate(maps.length, (i) {
      return Goal.fill(
        id: maps[i]['id'],
        title: maps[i]['title'],
        distance: maps[i]['distance'],
        duration: Duration(seconds: maps[i]['duration']),
      );
    });
  }

  Future<List<Activity>> getActivities() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('Activity');
    return List.generate(maps.length, (i) {
      return Activity.fill(
        id: maps[i]['id'],
        distance: maps[i]['distance'],
        duration: Duration(seconds: maps[i]['duration']),
        goalId: maps[i]['goalId'],
        goal: null,
      );
    });
  }

  Future<AuthState> getAuthState() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('AuthState');
    var list = List.generate(maps.length, (i) {
      return AuthState.fill(
        id: maps[i]['id'],
        accessToken: maps[i]['accessToken'],
        refreshToken: maps[i]['refreshToken'],
        username: maps[i]['userName'],
        expires: DateFormat().parse(maps[i]['expires']),
      );
    });
    return list.length > 0 ? list.first : null;
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