import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/essences_database.dart';
import 'package:dendro3/data/mapper/essence_list_mapper.dart';
import 'package:dendro3/data/mapper/essence_mapper.dart';
import 'package:dendro3/domain/model/essence.dart';
// import 'package:dendro3/domain/model/essence_id.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';

class EssencesRepositoryImpl implements EssencesRepository {
  final EssencesDatabase database;

  const EssencesRepositoryImpl(this.database);

  @override
  Future<EssenceList> getEssenceList() async {
    final essenceListEntity = await database.getEssenceList();
    return EssenceListMapper.transformToModel(essenceListEntity);
  }
}
