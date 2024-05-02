import 'package:dendro3/domain/model/corCyclePlacette.dart';

abstract class CreateCorCyclePlacetteUseCase {
  Future<CorCyclePlacette> execute(
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
