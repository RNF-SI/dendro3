import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase.dart';

class ExportDispositifDataUseCaseImpl implements ExportDispositifDataUseCase {
  final DispositifsRepository _repository;

  const ExportDispositifDataUseCaseImpl(this._repository);

  @override
  Future<void> execute(
    final int id,
  ) {
    return _repository.exportDispositifData(id);
  }
}
