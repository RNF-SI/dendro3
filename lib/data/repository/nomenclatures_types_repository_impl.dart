import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/nomenclatures_types_database.dart';
import 'package:dendro3/data/mapper/nomenclature_list_mapper.dart';
import 'package:dendro3/data/mapper/nomenclature_mapper.dart';
import 'package:dendro3/data/mapper/nomenclature_type_list_mapper.dart';
import 'package:dendro3/data/mapper/nomenclature_type_mapper.dart';
import 'package:dendro3/domain/model/nomenclature.dart';
import 'package:dendro3/domain/model/nomenclatureType_list.dart';
// import 'package:dendro3/domain/model/nomenclature_id.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/repository/nomenclatures_types_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NomenclaturesTypesRepositoryImpl implements NomenclaturesTypesRepository {
  final NomenclaturesTypesDatabase database;

  const NomenclaturesTypesRepositoryImpl(this.database);

  @override
  Future<NomenclatureTypeList> getNomenclatureTypeList() async {
    final nomenclatureTypeListEntity = await database.getNomenclatureTypeList();
    return NomenclatureTypeListMapper.transformToModel(
        nomenclatureTypeListEntity);
  }

  @override
  Future<int> getIdTypeNomenclatureFromMnemonique(String s) async {
    final nomenclatureTypeEntity =
        await database.getNomenclatureTypeFromMnemonique(s);
    final nomenclatureType =
        NomenclatureTypeMapper.transformToModel(nomenclatureTypeEntity);
    return nomenclatureType.idType;
  }
}
