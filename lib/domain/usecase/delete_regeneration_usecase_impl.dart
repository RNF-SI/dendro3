import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/regenerations_repository.dart';
import 'package:dendro3/domain/usecase/delete_regeneration_usecase.dart';

class DeleteRegenerationUseCaseImpl implements DeleteRegenerationUseCase {
  final CorCyclesPlacettesRepository _corCyclesPlacettesRepository;
  final RegenerationsRepository _regenerationRepository;

  DeleteRegenerationUseCaseImpl(
      this._corCyclesPlacettesRepository, this._regenerationRepository);

  @override
  Future<void> execute(String idCyclePlacette, String regenerationId) async {
    await _corCyclesPlacettesRepository
        .setCorCyclePlacetteAsUpdated(idCyclePlacette);
    await _regenerationRepository.deleteRegeneration(regenerationId);
  }
}
