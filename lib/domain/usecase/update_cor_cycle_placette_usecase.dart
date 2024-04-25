import 'package:dendro3/domain/model/corCyclePlacette.dart';

abstract class UpdateCorCyclePlacetteUseCase {
  Future<CorCyclePlacette> execute(
    idCyclePlacette,
    idCycle,
    idPlacette,
    dateReleve,
    dateIntervention,
    annee,
    natureIntervention,
    gestionPlacette,
    idNomenclatureCastor,
    idNomenclatureFrottis,
    idNomenclatureBoutis,
    recouvHerbesBasses,
    recouvHerbesHautes,
    recouvBuissons,
    recouvArbres,
    coeff,
    diamLim,
  );
}
