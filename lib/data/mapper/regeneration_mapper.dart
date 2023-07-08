import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:dendro3/domain/model/regeneration.dart';

class RegenerationMapper {
  // static Regeneration transformToModel(final RegenerationEntity entity) {
  //   return Regeneration(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static Regeneration transformFromApiToModel(final RegenerationEntity entity) {
    return Regeneration(
        idRegeneration: entity['id_regeneration'],
        idCyclePlacette: entity['id_cycle_placette'],
        sousPlacette: entity['sous_placette'],
        codeEssence: entity['code_essence'],
        recouvrement: entity['recouvrement'],
        classe1: entity['classe1'],
        classe2: entity['classe2'],
        classe3: entity['classe3'],
        taillis: entity['taillis'] == true ? true : false,
        abroutissement: entity['abroutissement'] == true ? true : false,
        idNomenclatureAbroutissement: entity['id_nomenclature_abroutissement'],
        observation: entity['observation']);
  }

  static RegenerationEntity transformToMap(final Regeneration model) {
    return {
      'id_regeneration': model.idRegeneration,
      'id_cycle_placette': model.idCyclePlacette,
      'sous_placette': model.sousPlacette,
      'code_essence': model.codeEssence,
      'recouvrement': model.recouvrement,
      'classe1': model.classe1,
      'classe2': model.classe2,
      'classe3': model.classe3,
      'taillis': model.taillis == true ? true : false,
      'abroutissement': model.abroutissement == true ? true : false,
      'id_nomenclature_abroutissement': model.idNomenclatureAbroutissement,
      'observation': model.observation,
    };
  }

  static RegenerationEntity transformToNewEntityMap(
      final int idCyclePlacette,
      final int sousPlacette,
      final String codeEssence,
      final double recouvrement,
      final int classe1,
      final int classe2,
      final int classe3,
      final bool taillis,
      final bool abroutissement,
      int? idNomenclatureAbroutissement,
      String? observation) {
    return {
      'id_regeneration': null,
      'id_cycle_placette': idCyclePlacette,
      'sous_placette': sousPlacette,
      'code_essence': codeEssence,
      'recouvrement': recouvrement,
      'classe1': classe1,
      'classe2': classe2,
      'classe3': classe3,
      'taillis': taillis == true ? true : false,
      'abroutissement': abroutissement == true ? true : false,
      'id_nomenclature_abroutissement': idNomenclatureAbroutissement,
      'observation': observation,
    };
  }

  static Regeneration transformToModel(RegenerationEntity regenerationsEntity) {
    return Regeneration(
        idRegeneration: regenerationsEntity['id_regeneration'],
        idCyclePlacette: regenerationsEntity['id_cycle_placette'],
        sousPlacette: regenerationsEntity['sous_placette'],
        codeEssence: regenerationsEntity['code_essence'],
        recouvrement: regenerationsEntity['recouvrement'],
        classe1: regenerationsEntity['classe'],
        classe2: regenerationsEntity['classe'],
        classe3: regenerationsEntity['classe'],
        taillis: regenerationsEntity['taillis'],
        abroutissement: regenerationsEntity['abroutissement'],
        idNomenclatureAbroutissement:
            regenerationsEntity['id_nomenclature_abroutissement'],
        observation: regenerationsEntity['observation']);
  }
  // static RegenerationEntity transformToNewEntityMap(
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
