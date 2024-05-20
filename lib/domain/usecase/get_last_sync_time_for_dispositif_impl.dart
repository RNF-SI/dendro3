import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/get_last_sync_time_for_dispositif.dart';

class GetLastSyncTimeForDispositifUseCaseImpl
    implements GetLastSyncTimeForDispositifUseCase {
  final LocalStorageRepository _localStorageRepository;

  GetLastSyncTimeForDispositifUseCaseImpl(this._localStorageRepository);

  @override
  Future<String?> execute(
    final int id,
  ) async {
    return await _localStorageRepository.getLastSyncTimeForDispositif(id);
  }
}
