import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/complete_cycle_placette_created_usecase.dart';

class CompleteCyclePlacetteCreatedUseCaseImpl
    implements CompleteCyclePlacetteCreatedUseCase {
  final LocalStorageRepository localStorageRepository;

  CompleteCyclePlacetteCreatedUseCaseImpl(this.localStorageRepository);

  @override
  Future<void> execute(String cycleId) async {
    await localStorageRepository.completeCyclePlacetteCreated(cycleId);
  }
}
