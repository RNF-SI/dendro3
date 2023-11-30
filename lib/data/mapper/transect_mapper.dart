import 'package:dendro3/data/entity/transects_entity.dart';
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

  static Transect transformFromApiToModel(final TransectEntity entity) {
    return Transect(
        idTransect: entity['id_transect'],
        idCyclePlacette: entity['id_cycle_placette'],
        idTransectOrig: entity['id_transect_orig'],
        codeEssence: entity['code_essence'],
        refTransect: entity['ref_transect'],
        distance: entity['distance'],
        orientation: entity['orientation'],
        azimutSouche: entity['azimut_souche'],
        distanceSouche: entity['distance_souche'],
        diametre: entity['diametre'],
        diametre130: entity['diametre_130'],
        ratioHauteur: entity['ratio_hauteur'] == true ? true : false,
        contact: entity['contact'] == true ? true : false,
        angle: entity['angle'],
        chablis: entity['chablis'] == true ? true : false,
        stadeDurete: entity['stade_durete'],
        stadeEcorce: entity['stade_ecorce'],
        observation: entity['observation']);
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
      'observation': model.observation
    };
  }

  static TransectEntity transformToNewEntityMap(
    int idCyclePlacette,
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
        ratioHauteur: transectsEntity['ratio_hauteur'] == true ? true : false,
        contact: transectsEntity['contact'] == true ? true : false,
        angle: transectsEntity['angle'],
        chablis: transectsEntity['chablis'] == true ? true : false,
        stadeDurete: transectsEntity['stade_durete'],
        stadeEcorce: transectsEntity['stade_ecorce'],
        observation: transectsEntity['observation']);
  }

  static TransectEntity transformToEntityMap(
    int idTransect,
    int idCyclePlacette,
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
