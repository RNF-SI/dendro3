import 'package:dendro3/data/datasource/interface/api/dispositifs_api.dart';
import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';

const String apiBase = "http://localhost:8000";

class DispositifsApiImpl implements DispositifsApi {
  Future<List<DispositifEntity>> getAllDispositifs() async {
    var url = "http://demo8161595.mockable.io/employee";
    Response response = await Dio().get(url);

    return (response.data as List).map((dispositif) {
      print('Inserting $dispositif');
      DBProvider.db.createEmployee(Dispositif.fromJson(dispositif));
    }).toList();
  }

  // static const _databaseName = 'psdrf_database';
  // static const _tableName = 'dispositifs_table';
  // static const _databaseVersion = 1;
  // static const _columnId = 'id_dispositif';
  // static const _columnName = 'name';
  // static const _columnIdOrganisme = 'id_organisme';
  // static const _columnAlluvial = 'alluvial';
  // static Database? _database;

  // Future<Database> get database async {
  //   _database ??= await _initDatabase();
  //   return _database!;
  // }

  // @override
  // Future<DispositifListEntity> allDispositifs() async {
  //   final db = await database;
  //   return db.query(_tableName);
  // }

  // @override
  // Future<DispositifEntity> insertDispositif(
  //     final DispositifEntity dispositif) async {
  //   final db = await database;
  //   late final DispositifEntity dispositifEntity;
  //   await db.transaction((txn) async {
  //     final id = await txn.insert(
  //       _tableName,
  //       dispositif,
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //     final results =
  //         await txn.query(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  //     dispositifEntity = results.first;
  //   });
  //   return dispositifEntity;
  // }

  // @override
  // Future<void> updateDispositif(final DispositifEntity dispositif) async {
  //   final db = await database;
  //   final int id = dispositif['id'];
  //   await db.update(
  //     _tableName,
  //     dispositif,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // @override
  // Future<void> deleteDispositif(final int id) async {
  //   final db = await database;
  //   await db.delete(
  //     _tableName,
  //     where: '$_columnId = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<Database> _initDatabase() async {
  //   return openDatabase(
  //     join(await getDatabasesPath(), _databaseName),
  //     onCreate: (db, _) {
  //       db.execute('''
  //         CREATE TABLE $_tableName(
  //           $_columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  //           $_columnName TEXT NOT NULL,
  //           $_columnIdOrganisme INTEGER,
  //           $_columnAlluvial INTEGER NOT NULL
  //         )
  //       ''');
  //     },
  //     version: _databaseVersion,
  //   );
  // }
}
