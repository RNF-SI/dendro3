import 'package:dendro3/data/datasource/implementation/database/db.dart';
import 'package:dendro3/data/datasource/interface/database/dispositifs_database.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GlobalDatabaseImpl implements GlobalDatabase {
  Future<Database> get database async {
    return await DB.instance.database;
  }

  @override
  Future<Database> initDatabase() async {
    return await DB.instance.database;
  }
}
