import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/get_is_logged_in_from_local_storage_use_case.dart';

class GetIsLoggedInFromLocalStorageUseCaseImpl
    implements GetIsLoggedInFromLocalStorageUseCase {
  final LocalStorageRepository _localStorageRepository;

  GetIsLoggedInFromLocalStorageUseCaseImpl(this._localStorageRepository);

  @override
  Future<bool> execute() async {
    return await _localStorageRepository.getIsLoggedIn();
  }
}
