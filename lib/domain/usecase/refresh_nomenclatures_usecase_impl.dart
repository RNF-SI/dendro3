import 'package:dendro3/domain/repository/global_database_repository.dart';
import 'package:dendro3/domain/usecase/refresh_nomenclatures_usecase.dart';

class RefreshNomenclaturesUseCaseImpl implements RefreshNomenclaturesUseCase {
  final GlobalDatabaseRepository repository;

  RefreshNomenclaturesUseCaseImpl(this.repository);

  @override
  Future<void> execute() async {
    await repository.refreshNomenclatures();
  }
}
