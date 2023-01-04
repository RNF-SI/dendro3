import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/data/mapper/bmSup30Mesure_list_mapper.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';

class BmSup30Mapper {
  // static BmSup30 transformToModel(final BmSup30Entity entity) {
  //   return BmSup30(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static BmSup30 transformFromApiToModel(final BmSup30Entity entity) {
    return BmSup30(
        idBmSup30: entity['id_bm_sup_30'],
        idBmSup30Orig: entity['id_bm_sup_30_orig'],
        idPlacette: entity['id_placette'],
        idArbre: entity['id_arbre'],
        codeEssence: entity['code_essence'],
        azimut: entity['azimut'],
        distance: entity['distance'],
        orientation: entity['orientation'],
        azimutSouche: entity['azimut_souche'],
        distanceSouche: entity['distance_souche'],
        observation: entity['observation'],
        bmsSup30Mesures: entity.containsKey('bm_sup_30_mesures')
            ? BmSup30MesureListMapper.transformFromApiToModel(
                entity['bm_sup_30_mesures'])
            : null);
  }

  static BmSup30Entity transformToMap(final BmSup30 model) {
    return {
      'id_bm_sup_30': model.idBmSup30,
      'id_bm_sup_30_orig': model.idBmSup30Orig,
      'id_placette': model.idPlacette,
      'id_arbre': model.idArbre,
      'code_essence': model.codeEssence,
      'azimut': model.azimut,
      'distance': model.distance,
      'orientation': model.orientation,
      'azimut_souche': model.azimutSouche,
      'distance_souche': model.distanceSouche,
      'observation': model.observation,
      'bm_sup_30_mesures': model.bmsSup30Mesures != null
          ? BmSup30MesureListMapper.transformToMap(model.bmsSup30Mesures!)
          : null
    };
  }

  // static BmSup30Entity transformToNewEntityMap(
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
