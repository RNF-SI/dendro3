import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';

class BmSup30MesureMapper {
  // static BmSup30Mesure transformToModel(final BmSup30MesureEntity entity) {
  //   return BmSup30Mesure(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static BmSup30Mesure transformFromApiToModel(
      final Map<String, dynamic> entity) {
    try {
      return BmSup30Mesure(
        idBmSup30Mesure: entity['id_bm_sup_30_mesure'] ??
            logAndReturnNull<String>('id_bm_sup_30_mesure'),
        idBmSup30:
            entity['id_bm_sup_30'] ?? logAndReturnNull<String>('id_bm_sup_30'),
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        diametreIni: entity['diametre_ini'] as double?,
        diametreMed: entity['diametre_med'] as double?,
        diametreFin: entity['diametre_fin'] as double?,
        diametre130: entity['diametre_130'] as double?,
        longueur: entity['longueur'] ?? logAndReturnNull<double>('longueur'),
        ratioHauteur: entity['ratio_hauteur'] as bool?,
        contact: entity['contact'] ?? logAndReturnNull<double>('contact'),
        chablis: entity['chablis'] as bool? ?? false,
        stadeDurete:
            entity['stade_durete'] ?? logAndReturnNull<int>('stade_durete'),
        stadeEcorce:
            entity['stade_ecorce'] ?? logAndReturnNull<int>('stade_ecorce'),
        observation: entity['observation'] as String?,
        createdAt: entity['created_at'] != null
            ? DateTime.parse(entity['created_at'] as String)
            : DateTime.now(),
        updatedAt: entity['updated_at'] != null
            ? DateTime.parse(entity['updated_at'] as String)
            : DateTime.now(),
        createdBy: entity['created_by'] as String?,
        updatedBy: entity['updated_by'] as String?,
        createdOn: entity['created_on'] as String?,
        updatedOn: entity['updated_on'] as String?,
      );
    } catch (e) {
      print("Error in BmSup30Mesure transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      rethrow;
    }
  }

  static BmSup30Mesure transformFromDBToModel(
      final Map<String, dynamic> entity) {
    try {
      return BmSup30Mesure(
        idBmSup30Mesure: entity['id_bm_sup_30_mesure'] ??
            logAndReturnNull<String>('id_bm_sup_30_mesure'),
        idBmSup30:
            entity['id_bm_sup_30'] ?? logAndReturnNull<String>('id_bm_sup_30'),
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        diametreIni: entity['diametre_ini'] as double?,
        diametreMed: entity['diametre_med'] as double?,
        diametreFin: entity['diametre_fin'] as double?,
        diametre130: entity['diametre_130'] as double?,
        longueur: entity['longueur'] ?? logAndReturnNull<double>('longueur'),
        ratioHauteur: (entity['ratio_hauteur'] as int?) == 1,
        contact: entity['contact'] ?? logAndReturnNull<double>('contact'),
        chablis: (entity['chablis'] as int?) == 1,
        stadeDurete:
            entity['stade_durete'] ?? logAndReturnNull<int>('stade_durete'),
        stadeEcorce:
            entity['stade_ecorce'] ?? logAndReturnNull<int>('stade_ecorce'),
        observation: entity['observation'] as String?,
      );
    } catch (e) {
      print("Error in BmSup30Mesure transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      rethrow;
    }
  }

  // Function concentratingh only on arbre properties (and not on arbreMesures)
  static BmSup30Mesure transformToModel(final BmSup30MesureEntity entity) {
    return BmSup30Mesure(
        idBmSup30Mesure: entity['id_bm_sup_30_mesure'],
        idBmSup30: entity['id_bm_sup_30'],
        idCycle: entity['id_cycle'],
        diametreIni: entity['diametre_ini'],
        diametreMed: entity['diametre_med'],
        diametreFin: entity['diametre_fin'],
        diametre130: entity['diametre_130'],
        longueur: entity['longueur'],
        ratioHauteur: (entity['ratio_hauteur'] == true ||
                entity['ratio_hauteur'] == 1)
            ? true
            : (entity['ratio_hauteur'] == false || entity['ratio_hauteur'] == 0)
                ? false
                : null,
        contact: entity['contact'],
        chablis: (entity['chablis'] == true || entity['chablis'] == 1)
            ? true
            : false,
        stadeDurete: entity['stade_durete'],
        stadeEcorce: entity['stade_ecorce'],
        observation: entity['observation']);
  }

  static BmSup30MesureEntity transformToMap(final BmSup30Mesure model) {
    return {
      'id_bm_sup_30_mesure': model.idBmSup30Mesure,
      'id_bm_sup_30': model.idBmSup30,
      'id_cycle': model.idCycle,
      'diametre_ini': model.diametreIni,
      'diametre_med': model.diametreMed,
      'diametre_fin': model.diametreFin,
      'diametre_130': model.diametre130,
      'longueur': model.longueur,
      'ratio_hauteur': model.ratioHauteur,
      'contact': model.contact,
      'chablis': model.chablis,
      'stade_durete': model.stadeDurete,
      'stade_ecorce': model.stadeEcorce,
      'observation': model.observation,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'created_by': model.createdBy,
      'updated_by': model.updatedBy,
      'created_on': model.createdOn,
      'updated_on': model.updatedOn,
    };
  }

  static BmSup30MesureEntity transformToNewEntityMap(
      final String idBmSup30,
      final int idCycle,
      double? diametreIni,
      double? diametreMed,
      double? diametreFin,
      double? diametre130,
      final double longueur,
      bool? ratioHauteur,
      final double contact,
      final bool chablis,
      final int stadeDurete,
      final int stadeEcorce,
      String? observation) {
    return {
      'id_bm_sup_30': idBmSup30,
      'id_cycle': idCycle,
      'diametre_ini': diametreIni,
      'diametre_med': diametreMed,
      'diametre_fin': diametreFin,
      'diametre_130': diametre130,
      'longueur': longueur,
      'ratio_hauteur': ratioHauteur,
      'contact': contact,
      'chablis': chablis,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'observation': observation,
    };
  }

  static BmSup30MesureEntity transformToEntityMap(
      final String idBmSup30Mesure,
      final String idBmSup30,
      final int idCycle,
      double? diametreIni,
      double? diametreMed,
      double? diametreFin,
      double? diametre130,
      final double longueur,
      bool? ratioHauteur,
      final double contact,
      final bool chablis,
      final int stadeDurete,
      final int stadeEcorce,
      String? observation) {
    return {
      'id_bm_sup_30_mesure': idBmSup30Mesure,
      'id_bm_sup_30': idBmSup30,
      'id_cycle': idCycle,
      'diametre_ini': diametreIni,
      'diametre_med': diametreMed,
      'diametre_fin': diametreFin,
      'diametre_130': diametre130,
      'longueur': longueur,
      'ratio_hauteur': ratioHauteur,
      'contact': contact,
      'chablis': chablis,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'observation': observation,
    };
  }
}
