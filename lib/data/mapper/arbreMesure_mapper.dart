import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';

class ArbreMesureMapper {
  // static ArbreMesure transformToModel(final ArbreMesureEntity entity) {
  //   return ArbreMesure(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static ArbreMesure transformFromApiToModel(
      final Map<String, dynamic> entity) {
    try {
      return ArbreMesure(
        idArbreMesure: entity['id_arbre_mesure'] ??
            logAndReturnNull<String>('id_arbre_mesure'),
        idArbre: entity['id_arbre'] ?? logAndReturnNull<String>('id_arbre'),
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        diametre1: entity['diametre1'] as double?,
        diametre2: entity['diametre2'] as double?,
        type: entity['type'] as String?,
        hauteurTotale: entity['hauteur_totale'] as double?,
        hauteurBranche: entity['hauteur_branche'] as double?,
        stadeDurete: entity['stade_durete'] as int?,
        stadeEcorce: entity['stade_ecorce'] as int?,
        liane: entity['liane'] as String?,
        diametreLiane: entity['diametre_liane'] as double?,
        coupe: entity['coupe'] as String?,
        limite: entity['limite'] as bool? ?? false,
        idNomenclatureCodeSanitaire:
            entity['id_nomenclature_code_sanitaire'] as int?,
        codeEcolo: entity['code_ecolo'] as String?,
        refCodeEcolo: entity['ref_code_ecolo'] as String?,
        ratioHauteur: entity['ratio_hauteur'] as bool?,
        observation: entity['observation'] as String?,
        createdAt: entity['created_at'] != null
            ? DateTime.parse(entity['created_at'] as String)
            : null,
        updatedAt: entity['updated_at'] != null
            ? DateTime.parse(entity['updated_at'] as String)
            : null,
        createdBy: entity['created_by'] as String?,
        updatedBy: entity['updated_by'] as String?,
        createdOn: entity['created_on'] as String?,
        updatedOn: entity['updated_on'] as String?,
      );
    } catch (e) {
      print("Error in ArbreMesure transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      rethrow;
    }
  }

  static ArbreMesure transformFromDBToModel(final Map<String, dynamic> entity) {
    try {
      return ArbreMesure(
        idArbreMesure: entity['id_arbre_mesure'] ??
            logAndReturnNull<String>('id_arbre_mesure'),
        idArbre: entity['id_arbre'] ?? logAndReturnNull<String>('id_arbre'),
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        diametre1: entity['diametre1'] as double?,
        diametre2: entity['diametre2'] as double?,
        type: entity['type'] as String?,
        hauteurTotale: entity['hauteur_totale'] as double?,
        hauteurBranche: entity['hauteur_branche'] as double?,
        stadeDurete: entity['stade_durete'] as int?,
        stadeEcorce: entity['stade_ecorce'] as int?,
        liane: entity['liane'] as String?,
        diametreLiane: entity['diametre_liane'] as double?,
        coupe: entity['coupe'] as String?,
        limite: (entity['limitye'] as int?) == 1,
        idNomenclatureCodeSanitaire:
            entity['id_nomenclature_code_sanitaire'] as int?,
        codeEcolo: entity['code_ecolo'] as String?,
        refCodeEcolo: entity['ref_code_ecolo'] as String?,
        ratioHauteur: (entity['ratio_hauteur'] as int?) == 1,
        observation: entity['observation'] as String?,
      );
    } catch (e) {
      print("Error in ArbreMesure transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");

      rethrow;
    }
  }

  static ArbreMesureEntity transformToMap(final ArbreMesure model) {
    return {
      'id_arbre_mesure': model.idArbreMesure,
      'id_arbre': model.idArbre,
      'id_cycle': model.idCycle,
      'diametre1': model.diametre1,
      'diametre2': model.diametre2,
      'type': model.type,
      'hauteur_totale': model.hauteurTotale,
      'hauteur_branche': model.hauteurBranche,
      'stade_durete': model.stadeDurete,
      'stade_ecorce': model.stadeEcorce,
      'liane': model.liane,
      'diametre_liane': model.diametreLiane,
      'coupe': model.coupe,
      'limite': model.limite == true ? true : false,
      'id_nomenclature_code_sanitaire': model.idNomenclatureCodeSanitaire,
      'code_ecolo': model.codeEcolo,
      'ref_code_ecolo': model.refCodeEcolo,
      'ratio_hauteur': model.ratioHauteur,
      'observation': model.observation,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'created_by': model.createdBy,
      'updated_by': model.updatedBy,
      'created_on': model.createdOn,
      'updated_on': model.updatedOn,
    };
  }

  static ArbreMesureEntity transformToNewEntityMap(
    final String? idArbre,
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  ) {
    return {
      'id_arbre': idArbre,
      'id_cycle': idCycle,
      'diametre1': diametre1,
      'diametre2': diametre2,
      'type': type,
      'hauteur_totale': hauteurTotale,
      'hauteur_branche': hauteurBranche,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'liane': liane,
      'diametre_liane': diametreLiane,
      'coupe': coupe,
      'limite': limite,
      'id_nomenclature_code_sanitaire': idNomenclatureCodeSanitaire,
      'code_ecolo': codeEcolo,
      'ref_code_ecolo': refCodeEcolo,
      'ratio_hauteur': ratioHauteur,
      'observation': observationMesure,
    };
  }

  static ArbreMesureEntity transformToEntityMap(
    final String? idArbreMesure,
    final String? idArbre,
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  ) {
    return {
      'id_arbre_mesure': idArbreMesure,
      'id_arbre': idArbre,
      'id_cycle': idCycle,
      'diametre1': diametre1,
      'diametre2': diametre2,
      'type': type,
      'hauteur_totale': hauteurTotale,
      'hauteur_branche': hauteurBranche,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'liane': liane,
      'diametre_liane': diametreLiane,
      'coupe': coupe,
      'limite': limite,
      'id_nomenclature_code_sanitaire': idNomenclatureCodeSanitaire,
      'code_ecolo': codeEcolo,
      'ref_code_ecolo': refCodeEcolo,
      'ratio_hauteur': ratioHauteur,
      'observation': observationMesure,
    };
  }

  // Function concentratingh only on arbre properties (and not on arbreMesures)
  static ArbreMesure transformToModel(final ArbreMesureEntity entity) {
    return ArbreMesure(
        idArbreMesure: entity['id_arbre_mesure'],
        idArbre: entity['id_arbre'],
        idCycle: entity['id_cycle'],
        diametre1: entity['diametre1'],
        diametre2: entity['diametre2'],
        type: entity['type'],
        hauteurTotale: entity['hauteur_totale'],
        hauteurBranche: entity['hauteur_branche'],
        stadeDurete: entity['stade_durete'],
        stadeEcorce: entity['stade_ecorce'],
        liane: entity['liane'],
        diametreLiane: entity['diametre_liane'],
        coupe: entity['coupe'],
        limite: entity['limite'] == true ? true : false,
        idNomenclatureCodeSanitaire: entity['id_nomenclature_code_sanitaire'],
        codeEcolo: entity['code_ecolo'],
        refCodeEcolo: entity['ref_code_ecolo'],
        ratioHauteur: entity['ratio_hauteur'] == true ? true : false,
        observation: entity['observation']);
  }
}
