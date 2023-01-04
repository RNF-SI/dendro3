import 'package:dendro3/data/datasource/interface/api/authentication_api.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/mapper/dispositif_list_mapper.dart';
import 'package:dendro3/data/mapper/user_mapper.dart';
import 'package:dendro3/domain/model/user.dart';
import 'package:dendro3/domain/repository/authentication_repository.dart';
import 'package:dendro3/domain/repository/global_database_repository.dart';

class GlobalDatabaseRepositoryImpl implements GlobalDatabaseRepository {
  final GlobalDatabase database;

  const GlobalDatabaseRepositoryImpl(this.database);

  @override
  Future<void> initDatabase() async {
    final db = await database.initDatabase();
  }
}
