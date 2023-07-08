import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:dendro3/domain/model/repere.dart';

class RepereMapper {
  // static Repere transformToModel(final RepereEntity entity) {
  //   return Repere(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static Repere transformFromApiToModel(final RepereEntity entity) {
    return Repere(
        idRepere: entity['id_repere'],
        idPlacette: entity['id_placette'],
        azimut: entity['azimut'],
        distance: entity['distance'],
        diametre: entity['diametre'],
        repere: entity['repere'],
        observation: entity['observation']);
  }

  static RepereEntity transformToMap(final Repere model) {
    return {
      'id_repere': model.idRepere,
      'id_placette': model.idPlacette,
      'azimut': model.azimut,
      'distance': model.distance,
      'diametre': model.diametre,
      'repere': model.repere,
      'observation': model.observation
    };
  }

  static RepereEntity transformToNewEntityMap(
    int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  ) {
    return {
      'id_repere': null,
      'id_placette': idPlacette,
      'azimut': azimut,
      'distance': distance,
      'diametre': diametre,
      'repere': repere,
      'observation': observation
    };
  }

  static Repere transformToModel(RepereEntity reperesEntity) {
    return Repere(
        idRepere: reperesEntity['id_repere'],
        idPlacette: reperesEntity['id_placette'],
        azimut: reperesEntity['azimut'],
        distance: reperesEntity['distance'],
        diametre: reperesEntity['diametre'],
        repere: reperesEntity['repere'],
        observation: reperesEntity['observation']);
  }

  // static RepereEntity transformToNewEntityMap(
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
