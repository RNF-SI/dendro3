import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/get_cor_cycle_placette_local_storage_provider.dart';

class GetInProgressCorCyclePlacetteLocalStorageUseCaseImpl
    implements GetInProgressCorCyclePlacetteLocalStorageUseCase {
  final LocalStorageRepository localStorageRepository;

  const GetInProgressCorCyclePlacetteLocalStorageUseCaseImpl(
      this.localStorageRepository);

  @override
  List<String> execute() {
    return localStorageRepository.getInProgressCorCyclePlacette();
  }
}
