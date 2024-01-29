import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/data/mapper/arbre_list_mapper.dart';
import 'package:dendro3/data/mapper/arbre_mapper.dart';
import 'package:dendro3/domain/model/arbre.dart';
// import 'package:dendro3/domain/model/arbre_id.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArbresRepositoryImpl implements ArbresRepository {
  final ArbresDatabase database;
  final ArbresMesuresRepository arbresMesuresRepository;

  const ArbresRepositoryImpl(this.database, this.arbresMesuresRepository);

  @override
  Future<Arbre> insertArbre(
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

  @override
  Future<Arbre> updateArbre(
    final String idArbre,
    final int idArbreOrig,
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
  ) async {
    final arbreEntity =
        await database.updateArbre(ArbreMapper.transformToEntityMap(
      idArbre,
      idArbreOrig,
      idPlacette,
      codeEssence,
      azimut,
      distance,
      taillis,
      observation,
    ));
    return ArbreMapper.transformToModel(arbreEntity);
  }

  @override
  Future<void> deleteArbre(final String idArbre) async {
    await database.deleteArbre(idArbre);
  }

  @override
  Future<List<String>> getArbreIdsForPlacette(int idPlacette) async {
    return await database.getArbreIdsForPlacette(idPlacette);
  }

  @override
  Future<void> deleteArbreAndArbreMesureFromIdArbre(String idArbre) async {
    await arbresMesuresRepository.deleteArbreMesureFromIdArbre(idArbre);
    await database.deleteArbre(idArbre);
  }
}
