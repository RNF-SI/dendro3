import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_from_api_usecase.dart';

class GetDispositifListFromApiUseCaseImpl implements GetDispositifListFromApiUseCase {
  final DispositifsRepository _repository;

  const GetDispositifListFromApiUseCaseImpl(this._repository);

  @override
  Future<DispositifList> execute() => _repository.getDispositifListFromAPI();
}
