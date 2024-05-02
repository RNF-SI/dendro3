import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/clear_user_name_from_local_storage_use_case.dart';

class ClearUserNameFromLocalStorageUseCaseImpl
    implements ClearUserNameFromLocalStorageUseCase {
  final LocalStorageRepository _repository;

  const ClearUserNameFromLocalStorageUseCaseImpl(this._repository);

  @override
  Future<void> execute() async {
    await _repository.clearUserName();
  }
}
