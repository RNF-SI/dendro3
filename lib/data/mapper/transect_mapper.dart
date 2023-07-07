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
