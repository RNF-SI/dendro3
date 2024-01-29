import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
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

  static Repere transformFromApiToModel(final Map<String, dynamic> entity) {
    try {
      return Repere(
        idRepere: entity['id_repere'] ?? logAndReturnNull<String>('id_repere'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        azimut: entity['azimut'] as double?,
        distance: entity['distance'] as double?,
        diametre: entity['diametre'] as double?,
        repere: entity['repere'] as String?,
        observation: entity['observation'] as String?,
      );
    } catch (e) {
      print("Error in Repere transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");
      throw e;
    }
  }

  static Repere transformFromDBToModel(final Map<String, dynamic> entity) {
    try {
      return Repere(
        idRepere: entity['id_repere'] ?? logAndReturnNull<String>('id_repere'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        azimut: entity['azimut'] as double?,
        distance: entity['distance'] as double?,
        diametre: entity['diametre'] as double?,
        repere: entity['repere'] as String?,
        observation: entity['observation'] as String?,
      );
    } catch (e) {
      print("Error in Repere transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");
      throw e;
    }
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

  static RepereEntity transformToEntityMap(
    String idRepere,
    int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  ) {
    return {
      'id_repere': idRepere,
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
