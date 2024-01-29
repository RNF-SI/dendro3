import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_mesures_database.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/data/mapper/arbreMesure_mapper.dart';
import 'package:dendro3/data/mapper/arbre_list_mapper.dart';
import 'package:dendro3/data/mapper/arbre_mapper.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
// import 'package:dendro3/domain/model/arbre_id.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';

class ArbresMesuresRepositoryImpl implements ArbresMesuresRepository {
  final ArbresMesuresDatabase database;

  const ArbresMesuresRepositoryImpl(this.database);

  @override
  Future<ArbreMesure> insertArbreMesure(
    final String? idArbre,
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  ) async {
    final arbreEntity =
        await database.addArbreMesure(ArbreMesureMapper.transformToNewEntityMap(
      idArbre,
      idCycle,
      diametre1,
      diametre2,
      type,
      hauteurTotale,
      hauteurBranche,
      stadeDurete,
      stadeEcorce,
      liane,
      diametreLiane,
      coupe,
      limite,
      idNomenclatureCodeSanitaire,
      codeEcolo,
      refCodeEcolo,
      ratioHauteur,
      observationMesure,
    ));

    return ArbreMesureMapper.transformToModel(arbreEntity);
  }

  @override
  Future<ArbreMesure> updateArbreMesure(
    final String? idArbreMesure,
    final String? idArbre,
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  ) async {
    final arbreEntity =
        await database.updateArbreMesure(ArbreMesureMapper.transformToEntityMap(
      idArbreMesure,
      idArbre,
      idCycle,
      diametre1,
      diametre2,
      type,
      hauteurTotale,
      hauteurBranche,
      stadeDurete,
      stadeEcorce,
      liane,
      diametreLiane,
      coupe,
      limite,
      idNomenclatureCodeSanitaire,
      codeEcolo,
      refCodeEcolo,
      ratioHauteur,
      observationMesure,
    ));

    return ArbreMesureMapper.transformToModel(arbreEntity);
  }

  @override
  Future<ArbreMesure> getPreviousCycleMeasure(
    final String idArbre,
    final int? idCycle,
    int? numCycle,
  ) async {
    final arbreEntity =
        await database.getPreviousCycleMeasure(idArbre, idCycle, numCycle);
    return ArbreMesureMapper.transformToModel(arbreEntity);
  }

  @override
  Future<ArbreMesure> updateLastArbreMesureCoupe(
    final String idArbreMesure,
    final String? coupe,
  ) async {
    final arbreEntity =
        await database.updateLastArbreMesureCoupe(idArbreMesure, coupe);
    return ArbreMesureMapper.transformToModel(arbreEntity);
  }

  @override
  Future<void> deleteArbreMesureFromIdArbre(final String idArbre) async {
    await database.deleteArbreMesureFromIdArbre(idArbre);
  }

  @override
  Future<void> deleteArbreMesure(final String idArbre) async {
    await database.deleteArbreMesure(idArbre);
  }
}
