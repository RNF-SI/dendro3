import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/transects_repository.dart';
import 'package:dendro3/domain/usecase/delete_transect_usecase.dart';

class DeleteTransectUseCaseImpl implements DeleteTransectUseCase {
  final CorCyclesPlacettesRepository _corCyclesPlacettesRepository;
  final TransectsRepository _transectRepository;

  DeleteTransectUseCaseImpl(
    this._corCyclesPlacettesRepository,
    this._transectRepository,
  );

  @override
  Future<void> execute(String idCyclePlacette, String transectId) async {
    await _corCyclesPlacettesRepository
        .setCorCyclePlacetteAsUpdated(idCyclePlacette);
    await _transectRepository.deleteTransect(transectId);
  }
}
