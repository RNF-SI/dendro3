import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';
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

  static CorCyclePlacette transformFromApiToModel(
      final CorCyclePlacetteEntity entity) {
    return CorCyclePlacette(
        idCyclePlacette: entity['id_cycle_placette'],
        idCycle: entity['id_cycle'],
        idPlacette: entity['id_placette'],
        dateReleve: DateTime.parse(entity['date_releve']),
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
        transects: entity.containsKey('transects')
            ? TransectListMapper.transformFromApiToModel(entity['transects'])
            : null,
        regenerations: entity.containsKey('regenerations')
            ? RegenerationListMapper.transformFromApiToModel(
                entity['regenerations'])
            : null);
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
      'transects': model.transects != null
          ? TransectListMapper.transformToMap(model.transects!)
          : null,
      'regenerations': model.regenerations != null
          ? RegenerationListMapper.transformToMap(model.regenerations!)
          : null
    };
  }

  // static CorCyclePlacetteEntity transformToNewEntityMap(
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
