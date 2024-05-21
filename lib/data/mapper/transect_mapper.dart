import 'package:dendro3/data/entity/transects_entity.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
import 'package:dendro3/domain/model/transect.dart';

class TransectMapper {
  // static Transect transformToModel(final TransectEntity entity) {
  //   return Transect(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static Transect transformFromApiToModel(final Map<String, dynamic> entity) {
    try {
      return Transect(
        idTransect:
            entity['id_transect'] ?? logAndReturnNull<String>('id_transect'),
        idCyclePlacette: entity['id_cycle_placette'] ??
            logAndReturnNull<String>('id_cycle_placette'),
        idTransectOrig: entity['id_transect_orig'] ??
            logAndReturnNull<int>('id_transect_orig'),
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        refTransect:
            entity['ref_transect'] ?? logAndReturnNull<String>('ref_transect'),
        distance: entity['distance'] as double?,
        orientation: entity['orientation'] as double?,
        azimutSouche: entity['azimut_souche'] as double?,
        distanceSouche: entity['distance_souche'] as double?,
        diametre: entity['diametre'] ?? logAndReturnNull<double>('diametre'),
        diametre130: entity['diametre130'] as double?,
        ratioHauteur: entity['ratio_hauteur'] as bool?,
        contact: entity['contact'] ?? logAndReturnNull<double>('contact'),
        angle: entity['angle'] ?? logAndReturnNull<double>('angle'),
        chablis: entity['chablis'] as bool? ?? false,
        stadeDurete:
            entity['stade_durete'] ?? logAndReturnNull<int>('stade_durete'),
        stadeEcorce:
            entity['stade_ecorce'] ?? logAndReturnNull<int>('stade_ecorce'),
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
      );
    } catch (e) {
      print("Error in Transect transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");
      rethrow;
    }
  }

  static Transect transformFromDBToModel(final Map<String, dynamic> entity) {
    try {
      return Transect(
        idTransect:
            entity['id_transect'] ?? logAndReturnNull<String>('id_transect'),
        idCyclePlacette: entity['id_cycle_placette'] ??
            logAndReturnNull<String>('id_cycle_placette'),
        idTransectOrig: entity['id_transect_orig'] ??
            logAndReturnNull<int>('id_transect_orig'),
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        refTransect:
            entity['ref_transect'] ?? logAndReturnNull<String>('ref_transect'),
        distance: entity['distance'] as double?,
        orientation: entity['orientation'] as double?,
        azimutSouche: entity['azimut_souche'] as double?,
        distanceSouche: entity['distance_souche'] as double?,
        diametre: entity['diametre'] ?? logAndReturnNull<double>('diametre'),
        diametre130: entity['diametre130'] as double?,
        ratioHauteur: (entity['ratio_hauteur'] as int?) == 1,
        contact: (entity['contact'] as int?) == 1,
        angle: entity['angle'] ?? logAndReturnNull<double>('angle'),
        chablis: (entity['chablis'] as int?) == 1,
        stadeDurete:
            entity['stade_durete'] ?? logAndReturnNull<int>('stade_durete'),
        stadeEcorce:
            entity['stade_ecorce'] ?? logAndReturnNull<int>('stade_ecorce'),
        observation: entity['observation'] as String?,
      );
    } catch (e) {
      print("Error in Transect transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");
      rethrow;
    }
  }

  static TransectEntity transformToMap(final Transect model) {
    return {
      'id_transect': model.idTransect,
      'id_cycle_placette': model.idCyclePlacette,
      'id_transect_orig': model.idTransectOrig,
      'code_essence': model.codeEssence,
      'ref_transect': model.refTransect,
      'distance': model.distance,
      'orientation': model.orientation,
      'azimut_souche': model.azimutSouche,
      'distance_souche': model.distanceSouche,
      'diametre': model.diametre,
      'diametre_130': model.diametre130,
      'ratio_hauteur': model.ratioHauteur == true ? true : false,
      'contact': model.contact == true ? true : false,
      'angle': model.angle,
      'chablis': model.chablis == true ? true : false,
      'stade_durete': model.stadeDurete,
      'stade_ecorce': model.stadeEcorce,
      'observation': model.observation,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'created_by': model.createdBy,
      'updated_by': model.updatedBy,
      'created_on': model.createdOn,
      'updated_on': model.updatedOn,
    };
  }

  static TransectEntity transformToNewEntityMap(
    String idCyclePlacette,
    String codeEssence,
    String refTransect,
    double? distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    double diametre,
    double? diametre130,
    bool? ratioHauteur,
    bool contact,
    double angle,
    bool chablis,
    int stadeDurete,
    int stadeEcorce,
    String? observation,
  ) {
    return {
      'id_transect': null,
      'id_cycle_placette': idCyclePlacette,
      'id_transect_orig': null,
      'code_essence': codeEssence,
      'ref_transect': refTransect,
      'distance': distance,
      'orientation': orientation,
      'azimut_souche': azimutSouche,
      'distance_souche': distanceSouche,
      'diametre': diametre,
      'diametre_130': diametre130,
      'ratio_hauteur': ratioHauteur == true ? true : false,
      'contact': contact == true ? true : false,
      'angle': angle,
      'chablis': chablis == true ? true : false,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'observation': observation
    };
  }

  static Transect transformToModel(TransectEntity transectsEntity) {
    return Transect(
        idTransect: transectsEntity['id_transect'],
        idCyclePlacette: transectsEntity['id_cycle_placette'],
        idTransectOrig: transectsEntity['id_transect_orig'],
        codeEssence: transectsEntity['code_essence'],
        refTransect: transectsEntity['ref_transect'],
        distance: transectsEntity['distance'],
        orientation: transectsEntity['orientation'],
        azimutSouche: transectsEntity['azimut_souche'],
        distanceSouche: transectsEntity['distance_souche'],
        diametre: transectsEntity['diametre'],
        diametre130: transectsEntity['diametre_130'],
        ratioHauteur: (transectsEntity['ratio_hauteur'] == true ||
                transectsEntity['ratio_hauteur'] == 1)
            ? true
            : (transectsEntity['ratio_hauteur'] == false ||
                    transectsEntity['ratio_hauteur'] == 0)
                ? false
                : null,
        contact: (transectsEntity['contact'] == true ||
                transectsEntity['contact'] == 1)
            ? true
            : false,
        angle: transectsEntity['angle'],
        chablis: (transectsEntity['chablis'] == true ||
                transectsEntity['chablis'] == 1)
            ? true
            : false,
        stadeDurete: transectsEntity['stade_durete'],
        stadeEcorce: transectsEntity['stade_ecorce'],
        observation: transectsEntity['observation']);
  }

  static TransectEntity transformToEntityMap(
    String idTransect,
    String idCyclePlacette,
    int idTransectOrig,
    String codeEssence,
    String refTransect,
    double? distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    double diametre,
    double? diametre130,
    bool? ratioHauteur,
    bool contact,
    double angle,
    bool chablis,
    int stadeDurete,
    int stadeEcorce,
    String? observation,
  ) {
    return {
      'id_transect': idTransect,
      'id_cycle_placette': idCyclePlacette,
      'id_transect_orig': idTransectOrig,
      'code_essence': codeEssence,
      'ref_transect': refTransect,
      'distance': distance,
      'orientation': orientation,
      'azimut_souche': azimutSouche,
      'distance_souche': distanceSouche,
      'diametre': diametre,
      'diametre_130': diametre130,
      'ratio_hauteur': ratioHauteur == true ? true : false,
      'contact': contact == true ? true : false,
      'angle': angle,
      'chablis': chablis == true ? true : false,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'observation': observation
    };
  }

  // static TransectEntity transformToNewEntityMap(
  //   final String name,
  //   final int idOrganisme,
  //   final bool alluvial,
  // ) {
  //   return {
  //     'id': null,
  //     'name': name,
  //     'idOrganisme': idOrganisme,
  //     'alluvial': alluvial ? 1 : 0,
  //   };
  // }
}
