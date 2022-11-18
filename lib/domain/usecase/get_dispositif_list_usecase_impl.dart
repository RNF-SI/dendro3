import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_usecase.dart';

class GetDispositifListUseCaseImpl implements GetDispositifListUseCase {
  final DispositifsRepository _repository;

  const GetDispositifListUseCaseImpl(this._repository);

  @override
  Future<DispositifList> execute() => _repository.getDispositifList();
}
