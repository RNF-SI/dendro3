import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';

class DeleteDispositifUseCaseImpl implements DeleteDispositifUseCase {
  final DispositifsRepository _repository;
  final PlacettesRepository _placettesRepository;

  const DeleteDispositifUseCaseImpl(
      this._repository, this._placettesRepository);

  @override
  Future<void> execute(
    final int dispositifId,
  ) async {
    // Fetch and delete each placette related to the dispositif
    var placettes =
        await _placettesRepository.getPlacettesForDispositif(dispositifId);
    for (var placette in placettes) {
      await _placettesRepository.deletePlacette(placette.idPlacette);
    }

    _repository.deleteDispositif(dispositifId);
  }
}
