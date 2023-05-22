import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/data/mapper/arbre_list_mapper.dart';
import 'package:dendro3/data/mapper/arbre_mapper.dart';
import 'package:dendro3/domain/model/arbre.dart';
// import 'package:dendro3/domain/model/arbre_id.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';

class ArbresRepositoryImpl implements ArbresRepository {
  final ArbresDatabase database;

  const ArbresRepositoryImpl(this.database);

  @override
  Future<Arbre> insertArbre(
    // final int idArbreOrig,
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
  ) async {
    final arbreEntity =
        await database.addArbre(ArbreMapper.transformToNewEntityMap(
      // idArbreOrig,
      idPlacette,
      codeEssence,
      azimut,
      distance,
      taillis,
      observation,
    ));
    return ArbreMapper.transformToModel(arbreEntity);
  }
}
