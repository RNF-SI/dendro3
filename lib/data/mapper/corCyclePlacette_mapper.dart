import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
import 'package:dendro3/data/mapper/regeneration_list_mapper.dart';
import 'package:dendro3/data/mapper/transect_list_mapper.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:intl/intl.dart';

class CorCyclePlacetteMapper {
  // static CorCyclePlacette transformToModel(final CorCyclePlacetteEntity entity) {
  //   return CorCyclePlacette(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static CorCyclePlacette transformToModel(
      final CorCyclePlacetteEntity entity) {
    DateTime? parsedDateReleve;
    if (entity['date_releve'] != null) {
      parsedDateReleve =
          DateFormat('yyyy-MM-dd').parse(entity['date_releve'], true);
    }
    return CorCyclePlacette(
      idCyclePlacette: entity['id_cycle_placette'],
      idCycle: entity['id_cycle'],
      idPlacette: entity['id_placette'],
      dateReleve: parsedDateReleve,
      dateIntervention: entity['date_intervention'],
      annee: entity['annee'],
      natureIntervention: entity['nature_intervention'],
      gestionPlacette: entity['gestion_placette'],
      idNomenclatureCastor: entity['id_nomenclature_castor'],
      idNomenclatureFrottis: entity['id_nomenclature_frottis'],
      idNomenclatureBoutis: entity['id_nomenclature_boutis'],
      recouvHerbesBasses: entity['recouv_herbes_basses'],
      recouvHerbesHautes: entity['recouv_herbes_hautes'],
      recouvBuissons: entity['recouv_buissons'],
      recouvArbres: entity['recouv_arbres'],
      coeff: entity['coeff'],
      diamLim: entity['diam_lim'],
    );
  }

  static CorCyclePlacette transformFromApiToModel(
      final Map<String, dynamic> entity) {
    try {
      return CorCyclePlacette(
        idCyclePlacette: entity['id_cycle_placette'] ??
            logAndReturnNull<String>('id_cycle_placette'),
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        dateReleve: entity['date_releve'] != null
            ? DateTime.parse(entity['date_releve'])
            : null,
        dateIntervention: entity['date_intervention'] as String?,
        annee: entity['annee'] as int?,
        natureIntervention: entity['nature_intervention'] as String?,
        gestionPlacette: entity['gestion_placette'] as String?,
        idNomenclatureCastor: entity['id_nomenclature_castor'] as int?,
        idNomenclatureFrottis: entity['id_nomenclature_frottis'] as int?,
        idNomenclatureBoutis: entity['id_nomenclature_boutis'] as int?,
        recouvHerbesBasses: entity['recouv_herbes_basses'] as double?,
        recouvHerbesHautes: entity['recouv_herbes_hautes'] as double?,
        recouvBuissons: entity['recouv_buissons'] as double?,
        recouvArbres: entity['recouv_arbres'] as double?,
        coeff: entity['coeff'] as int?,
        diamLim: entity['diam_lim'] as double?,
        transects: entity.containsKey('transects')
            ? TransectListMapper.transformFromApiToModel(entity['transects'])
            : null,
        regenerations: entity.containsKey('regenerations')
            ? RegenerationListMapper.transformFromApiToModel(
                entity['regenerations'])
            : null,
      );
    } catch (e) {
      print("Error in CorCyclePlacette transformFromApiToModel: $e");

      rethrow;
    }
  }

  static CorCyclePlacette transformFromDBToModel(
      final Map<String, dynamic> entity) {
    try {
      return CorCyclePlacette(
        idCyclePlacette: entity['id_cycle_placette'] ??
            logAndReturnNull<String>('id_cycle_placette'),
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        dateReleve: entity['date_releve'] != null
            ? DateTime.parse(entity['date_releve'])
            : null,
        dateIntervention: entity['date_intervention'] as String?,
        annee: entity['annee'] as int?,
        natureIntervention: entity['nature_intervention'] as String?,
        gestionPlacette: entity['gestion_placette'] as String?,
        idNomenclatureCastor: entity['id_nomenclature_castor'] as int?,
        idNomenclatureFrottis: entity['id_nomenclature_frottis'] as int?,
        idNomenclatureBoutis: entity['id_nomenclature_boutis'] as int?,
        recouvHerbesBasses: entity['recouv_herbes_basses'] as double?,
        recouvHerbesHautes: entity['recouv_herbes_hautes'] as double?,
        recouvBuissons: entity['recouv_buissons'] as double?,
        recouvArbres: entity['recouv_arbres'] as double?,
        coeff: entity['coeff'] as int?,
        diamLim: entity['diam_lim'] as double?,
        transects: entity.containsKey('transects')
            ? TransectListMapper.transformFromDBToModel(entity['transects'])
            : null,
        regenerations: entity.containsKey('regenerations')
            ? RegenerationListMapper.transformFromDBToModel(
                entity['regenerations'])
            : null,
      );
    } catch (e) {
      print("Error in CorCyclePlacette transformFromDBToModel: $e");

      rethrow;
    }
  }

  static CorCyclePlacetteEntity transformToMap(final CorCyclePlacette model) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return {
      'id_cycle_placette': model.idCyclePlacette,
      'id_cycle': model.idCycle,
      'id_placette': model.idPlacette,
      'date_releve':
          model.dateReleve != null ? formatter.format(model.dateReleve!) : null,
      'date_intervention': model.dateIntervention,
      'annee': model.annee,
      'nature_intervention': model.natureIntervention,
      'gestion_placette': model.gestionPlacette,
      'id_nomenclature_castor': model.idNomenclatureCastor,
      'id_nomenclature_frottis': model.idNomenclatureFrottis,
      'id_nomenclature_boutis': model.idNomenclatureBoutis,
      'recouv_herbes_basses': model.recouvHerbesBasses,
      'recouv_herbes_hautes': model.recouvHerbesHautes,
      'recouv_buissons': model.recouvBuissons,
      'recouv_arbres': model.recouvArbres,
      'coeff': model.coeff,
      'diam_lim': model.diamLim,
      'transects': model.transects != null
          ? TransectListMapper.transformToMap(model.transects!)
          : null,
      'regenerations': model.regenerations != null
          ? RegenerationListMapper.transformToMap(model.regenerations!)
          : null
    };
  }

  static CorCyclePlacetteEntity transformToNewEntityMap(
    // final int id_cor_cycle_placette,
    final int idCycle,
    final int idPlacette,
    final DateTime? dateReleve,
    final String? dateIntervention,
    final int? annee,
    final String? natureIntervention,
    final String gestionPlacette,
    final int? idNomenclatureCastor,
    final int? idNomenclatureFrottis,
    final int? idNomenclatureBoutis,
    final double? recouvHerbesBasses,
    final double? recouvHerbesHautes,
    final double? recouvBuissons,
    final double? recouvArbres,
    final int? coeff,
    final double? diamLim,
  ) {
    return {
      'id_cycle_placette': null,
      'id_cycle': idCycle,
      'id_placette': idPlacette,
      'date_releve': dateReleve,
      'date_intervention': dateIntervention,
      'annee': annee,
      'nature_intervention': natureIntervention,
      'gestion_placette': gestionPlacette,
      'id_nomenclature_castor': idNomenclatureCastor,
      'id_nomenclature_frottis': idNomenclatureFrottis,
      'id_nomenclature_boutis': idNomenclatureBoutis,
      'recouv_herbes_basses': recouvHerbesBasses,
      'recouv_herbes_hautes': recouvHerbesHautes,
      'recouv_buissons': recouvBuissons,
      'recouv_arbres': recouvArbres,
      'coeff': coeff,
      'diam_lim': diamLim,
    };
  }

  static CorCyclePlacetteEntity transformToEntityMap(
    final String idCyclePlacette,
    final int idCycle,
    final int idPlacette,
    final DateTime? dateReleve,
    final String? dateIntervention,
    final int? annee,
    final String? natureIntervention,
    final String gestionPlacette,
    final int? idNomenclatureCastor,
    final int? idNomenclatureFrottis,
    final int? idNomenclatureBoutis,
    final double? recouvHerbesBasses,
    final double? recouvHerbesHautes,
    final double? recouvBuissons,
    final double? recouvArbres,
    final int? coeff,
    final double? diamLim,
  ) {
    return {
      'id_cycle_placette': idCyclePlacette,
      'id_cycle': idCycle,
      'id_placette': idPlacette,
      'date_releve': dateReleve,
      'date_intervention': dateIntervention,
      'annee': annee,
      'nature_intervention': natureIntervention,
      'gestion_placette': gestionPlacette,
      'id_nomenclature_castor': idNomenclatureCastor,
      'id_nomenclature_frottis': idNomenclatureFrottis,
      'id_nomenclature_boutis': idNomenclatureBoutis,
      'recouv_herbes_basses': recouvHerbesBasses,
      'recouv_herbes_hautes': recouvHerbesHautes,
      'recouv_buissons': recouvBuissons,
      'recouv_arbres': recouvArbres,
      'coeff': coeff,
      'diam_lim': diamLim,
    };
  }
}
