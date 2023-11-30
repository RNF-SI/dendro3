import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/repository/regenerations_repository.dart';
import 'package:dendro3/domain/usecase/update_regeneration_usecase.dart';

class UpdateRegenerationUseCaseImpl implements UpdateRegenerationUseCase {
  final RegenerationsRepository _regenerationRepository;

  UpdateRegenerationUseCaseImpl(this._regenerationRepository);

  @override
  Future<Regeneration> execute(
    final int idRegeneration,
    final int idCyclePlacette,
    final int sousPlacette,
    final String codeEssence,
    final double recouvrement,
    final int classe1,
    final int classe2,
    final int classe3,
    final bool taillis,
    final bool abroutissement,
    int? idNomenclatureAbroutissement,
    String? observation,
  ) async {
    Regeneration regenerationUpdated =
        await _regenerationRepository.updateRegeneration(
      idRegeneration,
      idCyclePlacette,
      sousPlacette,
      codeEssence,
      recouvrement,
      classe1,
      classe2,
      classe3,
      taillis,
      abroutissement,
      idNomenclatureAbroutissement,
      observation,
    );

    return regenerationUpdated;
  }
}
