import 'package:dendro3/domain/model/corCyclePlacette.dart';

abstract class CorCyclesPlacettesRepository {
  Future<CorCyclePlacette> insertCorCyclePlacette(
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
  );

  Future<List<String>> getCorCyclePlacetteIdsForPlacette(final int placetteId);

  Future<void> deleteCorCyclePlacetteTransectAndRege(
      final String corCyclePlacetteId);
}
