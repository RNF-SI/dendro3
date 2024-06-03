import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
      version: _databaseVersion,
    );
  }

  Future<void> exportDatabase() async {
    if (!await _requestPermissions()) {
      throw Exception("Storage permission not granted");
    }

    final dbPath = join(await getDatabasesPath(), databaseName);

    // Get the downloads directory
    final downloadsDir = Directory('/storage/emulated/0/Download');
    if (!await downloadsDir.exists()) {
      throw Exception("Downloads directory not found");
    }

    final newPath = join(downloadsDir.path, databaseName);

    final dbFile = File(dbPath);
    if (await dbFile.exists()) {
      await dbFile.copy(newPath);
      print('Database copied to $newPath');
    } else {
      throw Exception("Database file does not exist");
    }
  }

  Future<bool> _requestPermissions() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    print('Current storage permission status: $storageStatus');
    return storageStatus.isGranted;
  }
}
