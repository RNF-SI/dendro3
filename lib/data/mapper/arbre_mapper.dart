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

  // Function concentratingh only on arbre properties (and not on arbreMesures)
  static Arbre transformToModel(final ArbreEntity entity) {
    return Arbre(
      idArbre: entity['id_arbre'],
      idArbreOrig: entity['id_arbre_orig'],
      idPlacette: entity['id_placette'],
      codeEssence: entity['code_essence'],
      azimut: entity['azimut'],
      distance: entity['distance'],
      taillis: entity['taillis'] == true ? true : false,
      observation: entity['observation'],
    );
  }

  // Function also converting arbreMesures
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
}
