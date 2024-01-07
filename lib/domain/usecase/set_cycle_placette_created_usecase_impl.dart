import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/set_cycle_placette_created_usecase.dart';

class SetCyclePlacetteCreatedUseCaseImpl
    implements SetCyclePlacetteCreatedUseCase {
  final LocalStorageRepository localStorageRepository;

  SetCyclePlacetteCreatedUseCaseImpl(this.localStorageRepository);

  @override
  Future<void> execute(int cycleId) async {
    await localStorageRepository.setCyclePlacetteCreated(cycleId);
  }
}
