import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/get_user_name_from_local_storage_use_case.dart';

class GetUserNameFromLocalStorageUseCaseImpl
    implements GetUserNameFromLocalStorageUseCase {
  final LocalStorageRepository _repository;

  const GetUserNameFromLocalStorageUseCaseImpl(this._repository);

  @override
  Future<String?> execute() {
    return _repository.getUserName();
  }
}
