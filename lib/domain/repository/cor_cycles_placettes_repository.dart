import 'package:dendro3/domain/model/corCyclePlacette.dart';

abstract class CorCyclesPlacettesRepository {
  Future<CorCyclePlacette> insertCorCyclePlacette(
    final int id_cycle,
    final int id_placette,
    final DateTime? date_releve,
    final String? date_intervention,
    final int? annee,
    final String? nature_intervention,
    final String gestion_placette,
    final int? id_nomenclature_castor,
    final int? id_nomenclature_frottis,
    final int? id_nomenclature_boutis,
    final double? recouv_herbes_basses,
    final double? recouv_herbes_hautes,
    final double? recouv_buissons,
    final double? recouv_arbres,
  );
}
