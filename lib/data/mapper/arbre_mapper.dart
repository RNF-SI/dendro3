import 'package:dendro3/core/helpers/format_DateTime.dart';
import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/data/mapper/arbreMesure_list_mapper.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
import 'package:dendro3/domain/model/arbre.dart';

class ArbreMapper {
  // static Arbre transformToModel(final ArbreEntity entity) {
  //   return Arbre(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  // Function concentratingh only on arbre properties (and not on arbreMesures)
  static Arbre transformToModel(final ArbreEntity entity) {
    return Arbre(
      idArbre: entity['id_arbre'],
      idArbreOrig: entity['id_arbre_orig'],
      idPlacette: entity['id_placette'],
      codeEssence: entity['code_essence'],
      azimut: entity['azimut'],
      distance: entity['distance'],
      taillis: (entity['taillis'] == true || entity['taillis'] == 1)
          ? true
          : (entity['taillis'] == false || entity['taillis'] == 0)
              ? false
              : null,
      observation: entity['observation'],
    );
  }

  // Function concentrating only on arbre properties (and not on arbreMesures)
  static Arbre transformFromApiToModel(final Map<String, dynamic> entity) {
    try {
      return Arbre(
        idArbre: entity['id_arbre'] ?? logAndReturnNull<String>('id_arbre'),
        idArbreOrig:
            entity['id_arbre_orig'] ?? logAndReturnNull<int>('id_arbre_orig'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        azimut: entity['azimut'] ?? logAndReturnNull<double>('azimut'),
        distance: entity['distance'] ?? logAndReturnNull<double>('distance'),
        taillis: entity['taillis'] as bool?,
        observation: entity['observation'] as String?,
        createdAt: entity['created_at'] != null
            ? DateTime.parse(entity['created_at'] as String)
            : DateTime.now().toUtc(),
        updatedAt: entity['updated_at'] != null
            ? DateTime.parse(entity['updated_at'] as String)
            : DateTime.now().toUtc(),
        createdBy: entity['created_by'] as String?,
        updatedBy: entity['updated_by'] as String?,
        createdOn: entity['created_on'] as String?,
        updatedOn: entity['updated_on'] as String?,
        arbresMesures: entity.containsKey('arbres_mesures')
            ? ArbreMesureListMapper.transformFromApiToModel(
                entity['arbres_mesures'])
            : null,
      );
    } catch (e) {
      print("Error in Arbre transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      rethrow;
    }
  }

  // Function concentratingh only on arbre properties (and not on arbreMesures)
  static Arbre transformFromDBToModel(final Map<String, dynamic> entity) {
    try {
      return Arbre(
        idArbre: entity['id_arbre'] ?? logAndReturnNull<String>('id_arbre'),
        idArbreOrig:
            entity['id_arbre_orig'] ?? logAndReturnNull<int>('id_arbre_orig'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        azimut: entity['azimut'] ?? logAndReturnNull<double>('azimut'),
        distance: entity['distance'] ?? logAndReturnNull<double>('distance'),
        taillis: (entity['taillis'] as int?) == 1,
        observation: entity['observation'] as String?,
        arbresMesures: entity.containsKey('arbres_mesures')
            ? ArbreMesureListMapper.transformFromDBToModel(
                entity['arbres_mesures'])
            : null,
      );
    } catch (e) {
      print("Error in Arbre transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      rethrow;
    }
  }

  static ArbreEntity transformToMap(final Arbre model) {
    return {
      'id_arbre': model.idArbre,
      'id_arbre_orig': model.idArbreOrig,
      'id_placette': model.idPlacette,
      'code_essence': model.codeEssence,
      'azimut': model.azimut,
      'distance': model.distance,
      'taillis': model.taillis,
      'observation': model.observation,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'created_by': model.createdBy,
      'updated_by': model.updatedBy,
      'created_on': model.createdOn,
      'updated_on': model.updatedOn,
      'arbres_mesures': model.arbresMesures != null
          ? ArbreMesureListMapper.transformToMap(model.arbresMesures!)
          : null
    };
  }

  static ArbreEntity transformToNewEntityMap(
    // final int idArbreOrig,
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
  ) {
    return {
      'id_arbre': null,
      'id_arbre_orig': null,
      'id_placette': idPlacette,
      'code_essence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'taillis': taillis,
      'observation': observation,
    };
  }

  static ArbreEntity transformToEntityMap(
    final String idArbre,
    final int idArbreOrig,
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
  ) {
    return {
      'id_arbre': idArbre,
      'id_arbre_orig': idArbreOrig,
      'id_placette': idPlacette,
      'code_essence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'taillis': taillis,
      'observation': observation,
    };
  }
}
