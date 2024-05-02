import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/usecase/update_cor_cycle_placette_usecase.dart';

class UpdateCorCyclePlacetteUseCaseImpl
    implements UpdateCorCyclePlacetteUseCase {
  final CorCyclesPlacettesRepository _corCyclePlacetteRepository;

  const UpdateCorCyclePlacetteUseCaseImpl(this._corCyclePlacetteRepository);

  @override
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
  ) async {
    CorCyclePlacette corCyclePlacette =
        await _corCyclePlacetteRepository.updateCorCyclePlacette(
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

    return corCyclePlacette;
  }
}
