import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/get_terminal_name_from_local_storage_use_case.dart';

class GetTerminalNameFromLocalStorageUseCaseImpl
    implements GetTerminalNameFromLocalStorageUseCase {
  final LocalStorageRepository _repository;

  const GetTerminalNameFromLocalStorageUseCaseImpl(this._repository);

  @override
  Future<String?> execute() {
    return _repository.getTerminalName();
  }
}
