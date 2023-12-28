import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:everyday_timer/features/cd_timer/data/data_source/timer_data.dart';
import 'package:everyday_timer/features/cd_timer/data/models/cd_timer.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';


Future<Database> _getDatabase() async{
  final dbPath = await sql.getDatabasesPath();
    //open the database
    final db = await sql.openDatabase(path.join(dbPath, 'timers.db'),
      // When the database is first created, create a table to store timer.
        onCreate: (db, version) {
      // creating the db, create the table
      return db.execute(
          '''CREATE TABLE user_timers(id TEXT PRIMARY KEY, 
          title TEXT, 
          time INTEGER,
          rest INTEGER,
          sets INTEGER,
          color INTEGER,
          setsOfTimer TEXT 
          )''');
    }, version: 1);
    return db;
}

class UserTimersNotifier extends StateNotifier<List<CdTimer>> {
  UserTimersNotifier() : super(const []);

  Future<void> loadTimers() async{
    // final db = await _getDatabase();
    // Query the table for all The timers.
    // final List<Map<String, dynamic>> maps = await db.query('user_timers');
    
    // final data = List.generate(maps.length, (i) => CdTimer.fromMap(maps[i]));

    // state = data;
  }


  Future<void> insertTimer(CdTimer cdTimer) async {
    //storing image as path
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(path);
    //image.copy('${appDir.path}/$filename');
    
    // final db = await _getDatabase();
    // await db.insert('user_timers', cdTimer.toMap(), conflictAlgorithm: ConflictAlgorithm.replace
    // );
    final newTimer = cdTimer;
    state = [newTimer, ...state];
  }

  Future<void> deleteTimer(CdTimer cdTimer)async{
    state = [
      for (final item in state)
        if (item != cdTimer) item,
    ];
  }
}

final userTimersProvider =
    StateNotifierProvider<UserTimersNotifier, List<CdTimer>>(
  (ref) => UserTimersNotifier(),
);
