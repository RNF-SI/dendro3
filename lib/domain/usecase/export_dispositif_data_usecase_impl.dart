import 'package:dendro3/core/helpers/export_objects.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase.dart';

class ExportDispositifDataUseCaseImpl implements ExportDispositifDataUseCase {
  final DispositifsRepository _repository;
  final ArbresRepository _arbreRepository;
  final BmsSup30Repository _bmsSup30Repository;
  final LocalStorageRepository _localStorageRepository;

  const ExportDispositifDataUseCaseImpl(
    this._repository,
    this._arbreRepository,
    this._bmsSup30Repository,
    this._localStorageRepository,
  );

  @override
  Future<ExportResults> execute(
    final int id,
    final String? lastSyncTime,
  ) async {
    TaskResult resultExport =
        await _repository.exportDispositifData(id, lastSyncTime);
    // Actualize the Arbre id_arbre_orig values
    _arbreRepository
        .actualizeArbreIdArbreOrigAfterSync(resultExport.createdArbres);
    _bmsSup30Repository
        .actualizeBmIdBmSup30OrigAfterSync(resultExport.createdBms);

    await _localStorageRepository.setLastSyncTimeForDispositif(
        id, DateTime.now());
    return resultExport.exportResults;
  }
}
