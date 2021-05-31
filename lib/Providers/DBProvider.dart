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
      await db.execute(
        """CREATE TABLE AuthState(id INTEGER PRIMARY KEY AUTOINCREMENT , userName TEXT, accessToken TEXT, refreshToken TEXT, expires DATETIME);""",
      );
      await db.execute(
        """CREATE TABLE Goal(id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT, distance DOUBLE, duration INTEGER, currentAmountOfStars INTEGER, beginday DATETIME, endday DATETIME);
        """,
      );
      await db.execute(
        """CREATE TABLE Activity(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, date DATETIME, distance DOUBLE, duration INTEGER, goalId INTEGER);""",
      );
    });
    return _database;
  }

  Future<int> insertGoal(Goal goal) async {
    final Database db = await getDatabase();
    return await db.insert('Goal', goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertActivity(Activity activity) async {
    final Database db = await getDatabase();
    return await db.insert('Activity', activity.toMap(),
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

  Future<int> removeGoal(Goal goal) async {
    try {
      final Database db = await getDatabase();
      var res = await db.delete("Goal", where: "id = ?", whereArgs: [goal.id]);
      return res;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  Future<int> removeActivity(Activity activity) async {
    try {
      final Database db = await getDatabase();
      var res = await db
          .delete("Activity", where: "id = ?", whereArgs: [activity.id]);
      return res;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  Future<int> removeActivityByGoal(Goal goal) async {
    try {
      final Database db = await getDatabase();
      var res = await db
          .delete("Activity", where: "goalId = ?", whereArgs: [goal.id]);
      return res;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  Future<List<Goal>> getGoals({String where, List<Object> whereArgs}) async {
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> maps =
          await db.query('Goal', where: where, whereArgs: whereArgs);
      return List.generate(maps.length, (i) {
        return Goal.fill(
          id: maps[i]['id'],
          title: maps[i]['title'],
          distance: maps[i]['distance'],
          duration: Duration(seconds: maps[i]['duration']),
          beginday: DateTime.parse(maps[i]['beginday']),
          endday: DateTime.parse(maps[i]['endday']),
          currentAmountOfStars: maps[i]['currentAmountOfStars'],
        );
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Activity>> getActivities(
      {String where, List<Object> whereArgs}) async {
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> maps =
          await db.query('Activity', where: where, whereArgs: whereArgs);
      return List.generate(maps.length, (i) {
        return Activity.fill(
          id: maps[i]['id'],
          name: maps[i]['name'],
          distance: maps[i]['distance'],
          duration: Duration(seconds: maps[i]['duration']),
          date: DateFormat().parse(maps[i]['date']),
          goalId: maps[i]['goalId'],
          goal: null,
        );
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AuthState> getAuthState() async {
    try {
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
    } catch (e) {
      print(e);
      return null;
    }
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
