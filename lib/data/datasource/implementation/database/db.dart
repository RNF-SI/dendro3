import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static final DB _db = DB._internal();
  DB._internal();
  static DB get instance => _db;
  static Database? _database;

  static const databaseName = 'psdrf_database';
  static const _databaseVersion = 1;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // add a function to set the database to null
  static void setDatabaseNull() {
    _database = null;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, _) async {
        String script = await rootBundle.loadString("assets/db/db_init.sql");
        List<String> scripts = script.split(";");
        for (var v in scripts) {
          if (v.isNotEmpty) {
            try {
              db.execute(v.trim());
            } catch (e) {
              print(e);
            }
          }
        }
      },
      // onConfigure: _onConfigure,
      version: _databaseVersion,
    );
  }

  // ToDo: add Foreign Key in futures dev
  // static Future _onConfigure(Database db) async {
  //   await db.execute('PRAGMA foreign_keys = ON');
  // }
}
