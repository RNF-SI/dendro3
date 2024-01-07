import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/is_cycle_placette_created_usecase.dart';

class IsCyclePlacetteCreatedUseCaseImpl
    implements IsCyclePlacetteCreatedUseCase {
  final LocalStorageRepository localStorageRepository;

  IsCyclePlacetteCreatedUseCaseImpl(this.localStorageRepository);

  @override
  bool execute(int cycleId) {
    return localStorageRepository.isCyclePlacetteCreated(cycleId);
  }
}
