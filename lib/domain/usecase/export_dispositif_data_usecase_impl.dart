import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase.dart';

class ExportDispositifDataUseCaseImpl implements ExportDispositifDataUseCase {
  final DispositifsRepository _repository;
  final ArbresRepository _arbreRepository;
  final BmsSup30Repository _bmsSup30Repository;

  const ExportDispositifDataUseCaseImpl(
    this._repository,
    this._arbreRepository,
    this._bmsSup30Repository,
  );

  @override
  Future<SyncResults> execute(
    final int id,
  ) async {
    TaskResult resultExport = await _repository.exportDispositifData(id);
    // Actualize the Arbre id_arbre_orig values
    _arbreRepository
        .actualizeArbreIdArbreOrigAfterSync(resultExport.createdArbres);
    _bmsSup30Repository
        .actualizeBmIdBmSup30OrigAfterSync(resultExport.createdBms);
    return resultExport.syncResults;
  }
}
