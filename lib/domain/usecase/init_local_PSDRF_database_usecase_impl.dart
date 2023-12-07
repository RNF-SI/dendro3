import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/global_database_repository.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';

class InitLocalPSDRFDataBaseUseCaseImpl
    implements InitLocalPSDRFDataBaseUseCase {
  final GlobalDatabaseRepository _repository;

  const InitLocalPSDRFDataBaseUseCaseImpl(this._repository);

  @override
  Future<void> execute() {
    return _repository.initDatabase();
  }
}
