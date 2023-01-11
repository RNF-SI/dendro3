import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/data/mapper/arbreMesure_list_mapper.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';

class ArbreMapper {
  // static Arbre transformToModel(final ArbreEntity entity) {
  //   return Arbre(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static Arbre transformFromApiToModel(final ArbreEntity entity) {
    return Arbre(
        idArbre: entity['id_arbre'],
        idArbreOrig: entity['id_arbre_orig'],
        idPlacette: entity['id_placette'],
        codeEssence: entity['code_essence'],
        azimut: entity['azimut'],
        distance: entity['distance'],
        taillis: entity['taillis'] == true ? true : false,
        observation: entity['observation'],
        arbresMesures: entity.containsKey('arbres_mesures')
            ? ArbreMesureListMapper.transformFromApiToModel(
                entity['arbres_mesures'])
            : null);
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
      'arbres_mesures': model.arbresMesures != null
          ? ArbreMesureListMapper.transformToMap(model.arbresMesures!)
          : null
    };
  }

  // static ArbreEntity transformToNewEntityMap(
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
