import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase.dart';

class GetUserDispositifListFromDBUseCaseImpl
    implements GetUserDispositifListFromDBUseCase {
  final DispositifsRepository _repository;

  const GetUserDispositifListFromDBUseCaseImpl(this._repository);

  @override
  Future<DispositifList> execute(
    final int id,
  ) {
    return _repository.getUserDispositifListFromDB(id);
  }
}
