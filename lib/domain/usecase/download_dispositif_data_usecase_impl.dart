import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';

class DownloadDispositifDataUseCaseImpl
    implements DownloadDispositifDataUseCase {
  final DispositifsRepository _repository;

  const DownloadDispositifDataUseCaseImpl(this._repository);

  @override
  Future<void> execute(
    final int id,
  ) {
    return _repository.downloadDispositifData(id);
  }
}
