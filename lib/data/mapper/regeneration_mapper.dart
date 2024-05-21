import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
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

  static Regeneration transformFromApiToModel(
      final Map<String, dynamic> entity) {
    try {
      return Regeneration(
        idRegeneration: entity['id_regeneration'] ??
            logAndReturnNull<String>('id_regeneration'),
        idCyclePlacette: entity['id_cycle_placette'] ??
            logAndReturnNull<String>('id_cycle_placette'),
        sousPlacette:
            entity['sous_placette'] ?? logAndReturnNull<int>('sous_placette'),
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        recouvrement:
            entity['recouvrement'] ?? logAndReturnNull<double>('recouvrement'),
        classe1: entity['classe1'] as int? ?? 0,
        classe2: entity['classe2'] as int? ?? 0,
        classe3: entity['classe3'] as int? ?? 0,
        taillis: entity['taillis'] == true ? true : false,
        abroutissement: entity['abroutissement'] == true ? true : false,
        idNomenclatureAbroutissement:
            entity['id_nomenclature_abroutissement'] as int?,
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
      print("Error in Regeneration transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");
      rethrow;
    }
  }

  static Regeneration transformFromDBToModel(
      final Map<String, dynamic> entity) {
    try {
      return Regeneration(
        idRegeneration: entity['id_regeneration'] ??
            logAndReturnNull<String>('id_regeneration'),
        idCyclePlacette: entity['id_cycle_placette'] ??
            logAndReturnNull<String>('id_cycle_placette'),
        sousPlacette:
            entity['sous_placette'] ?? logAndReturnNull<int>('sous_placette'),
        codeEssence:
            entity['code_essence'] ?? logAndReturnNull<String>('code_essence'),
        recouvrement:
            entity['recouvrement'] ?? logAndReturnNull<double>('recouvrement'),
        classe1: entity['classe1'] ?? logAndReturnNull<int>('classe1'),
        classe2: entity['classe2'] ?? logAndReturnNull<int>('classe2'),
        classe3: entity['classe3'] ?? logAndReturnNull<int>('classe3'),
        taillis: (entity['taillis'] as int?) == 1,
        abroutissement: (entity['abroutissement'] as int?) == 1,
        idNomenclatureAbroutissement:
            entity['id_nomenclature_abroutissement'] as int?,
        observation: entity['observation'] as String?,
      );
    } catch (e) {
      print("Error in Regeneration transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      rethrow;
    }
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
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'created_by': model.createdBy,
      'updated_by': model.updatedBy,
      'created_on': model.createdOn,
      'updated_on': model.updatedOn,
    };
  }

  static RegenerationEntity transformToNewEntityMap(
      final String idCyclePlacette,
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

  static RegenerationEntity transformToEntityMap(
      final String idRegeneration,
      final String idCyclePlacette,
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
      'id_regeneration': idRegeneration,
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
        classe1: regenerationsEntity['classe1'],
        classe2: regenerationsEntity['classe2'],
        classe3: regenerationsEntity['classe3'],
        taillis: (regenerationsEntity['taillis'] == true ||
                regenerationsEntity['taillis'] == 1)
            ? true
            : false,
        abroutissement: (regenerationsEntity['abroutissement'] == true ||
                regenerationsEntity['abroutissement'] == 1)
            ? true
            : false,
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
