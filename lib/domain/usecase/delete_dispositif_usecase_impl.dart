import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';

class DeleteDispositifUseCaseImpl implements DeleteDispositifUseCase {
  final DispositifsRepository _repository;

  const DeleteDispositifUseCaseImpl(this._repository);

  @override
  Future<void> execute(
    final int id,
  ) =>
      _repository.deleteDispositif(id);
}
