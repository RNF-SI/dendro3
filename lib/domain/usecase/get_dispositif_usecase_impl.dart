import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/get_dispositif_usecase.dart';

class GetDispositifUseCaseImpl implements GetDispositifUseCase {
  final DispositifsRepository _repository;

  const GetDispositifUseCaseImpl(this._repository);

  @override
  Future<Dispositif> execute(
    final int id,
  ) =>
      _repository.getDispositif(id);
}
