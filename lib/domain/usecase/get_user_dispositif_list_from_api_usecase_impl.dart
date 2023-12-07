import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase.dart';

class GetUserDispositifListFromAPIUseCaseImpl
    implements GetUserDispositifListFromAPIUseCase {
  final DispositifsRepository _repository;

  const GetUserDispositifListFromAPIUseCaseImpl(this._repository);

  @override
  Future<DispositifList> execute(
    final int id,
  ) {
    return _repository.getUserDispositifListFromAPI(id);
  }
}
