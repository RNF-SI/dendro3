import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/data/mapper/bmSup30Mesure_list_mapper.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
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

  static BmSup30 transformFromApiToModel(final Map<String, dynamic> entity) {
    try {
      return BmSup30(
        idBmSup30:
            entity['id_bm_sup_30'] ?? logAndReturnNull<String>('id_bm_sup_30'),
        idBmSup30Orig: entity['id_bm_sup_30_orig'] ??
            logAndReturnNull<int>('id_bm_sup_30_orig'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        idArbre: entity['id_arbre'] as int?,
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        azimut: entity['azimut'] as double?,
        distance: entity['distance'] as double?,
        orientation: entity['orientation'] as double?,
        azimutSouche: entity['azimut_souche'] as double?,
        distanceSouche: entity['distance_souche'] as double?,
        observation: entity['observation'] as String?,
        bmsSup30Mesures: entity.containsKey('bm_sup_30_mesures')
            ? BmSup30MesureListMapper.transformFromApiToModel(
                entity['bm_sup_30_mesures'])
            : null,
      );
    } catch (e) {
      print("Error in BmSup30 transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      throw e;
    }
  }

  static BmSup30 transformFromDBToModel(final Map<String, dynamic> entity) {
    try {
      return BmSup30(
        idBmSup30:
            entity['id_bm_sup_30'] ?? logAndReturnNull<String>('id_bm_sup_30'),
        idBmSup30Orig: entity['id_bm_sup_30_orig'] ??
            logAndReturnNull<int>('id_bm_sup_30_orig'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        idArbre: entity['id_arbre'] as int?,
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        azimut: entity['azimut'] as double?,
        distance: entity['distance'] as double?,
        orientation: entity['orientation'] as double?,
        azimutSouche: entity['azimut_souche'] as double?,
        distanceSouche: entity['distance_souche'] as double?,
        observation: entity['observation'] as String?,
        bmsSup30Mesures: entity.containsKey('bm_sup_30_mesures')
            ? BmSup30MesureListMapper.transformFromDBToModel(
                entity['bm_sup_30_mesures'])
            : null,
      );
    } catch (e) {
      print("Error in BmSup30 transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      throw e;
    }
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

  static BmSup30Entity transformToNewEntityMap(
    final int idPlacette,
    final String? idArbre,
    final String codeEssence,
    final double azimut,
    final double distance,
    final double? orientation,
    final double? azimutSouche,
    final double? distanceSouche,
    final String? observation,
  ) {
    return {
      'id_placette': idPlacette,
      'id_arbre': idArbre,
      'code_essence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'orientation': orientation,
      'azimut_souche': azimutSouche,
      'distance_souche': distanceSouche,
      'observation': observation,
    };
  }

  static BmSup30 transformToModel(final BmSup30Entity entity) {
    return BmSup30(
      idBmSup30: entity['id_bm_sup_30'],
      idBmSup30Orig: entity['id_bm_sup_30_orig'],
      idPlacette: entity['id_placette'],
      idArbre: entity['id_arbre'],
      codeEssence: entity['code_essence'],
      azimut: entity['azimut'],
      distance: entity['distance'],
      orientation: entity[' orientation'],
      azimutSouche: entity[' azimut_souche'],
      distanceSouche: entity[' distance_souche'],
      observation: entity[' observation'],
    );
  }

  static BmSup30Entity transformToEntityMap(
    final String idBmSup30,
    final int idBmSup30Orig,
    final int idPlacette,
    final int? idArbre,
    final String codeEssence,
    final double azimut,
    final double distance,
    final double? orientation,
    final double? azimutSouche,
    final double? distanceSouche,
    final String? observation,
  ) {
    return {
      'id_bm_sup_30': idBmSup30,
      'id_bm_sup_30_orig': idBmSup30Orig,
      'id_placette': idPlacette,
      'id_arbre': idArbre,
      'code_essence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'orientation': orientation,
      'azimut_souche': azimutSouche,
      'distance_souche': distanceSouche,
      'observation': observation
    };
  }
}
