import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/set_user_id_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/set_user_name_from_local_storage_use_case.dart';

class SetUserNameFromLocalStorageUseCaseImpl
    implements SetUserNameFromLocalStorageUseCase {
  final LocalStorageRepository _repository;

  const SetUserNameFromLocalStorageUseCaseImpl(this._repository);

  @override
  Future<void> execute(final String userName) {
    return _repository.setUserName(userName);
  }
}
