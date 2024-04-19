import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/usecase/create_cor_cycle_placette_usecase.dart';

class CreateCorCyclePlacetteUseCaseImpl
    implements CreateCorCyclePlacetteUseCase {
  // final CyclesRepository _cycleRepository;
  // final PlacettesRepository _placetteRepository;
  // final CorrelationsRepository _correlationRepository;
  final CorCyclesPlacettesRepository _corCyclePlacetteRepository;

  const CreateCorCyclePlacetteUseCaseImpl(this._corCyclePlacetteRepository);

  @override
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
  ) async {
    CorCyclePlacette corCyclePlacette =
        await _corCyclePlacetteRepository.insertCorCyclePlacette(
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

    // final cycle = await _cycleRepository.get(cycleId);
    // final placette = await _placetteRepository.get(placetteId);
    // final correlation = await _correlationRepository.get(correlationId);
    // final corCyclePlacette = CorCyclePlacette(
    //   cycleId: cycleId,
    //   placetteId: placetteId,
    //   correlationId: correlationId,
    //   id: id,
    // );
    // return _corCyclePlacetteRepository.create(corCyclePlacette);
    return corCyclePlacette;
  }
}
