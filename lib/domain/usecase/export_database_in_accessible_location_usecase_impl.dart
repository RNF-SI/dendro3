import 'package:dendro3/domain/repository/global_database_repository.dart';
import 'package:dendro3/domain/usecase/export_database_in_accessible_location_usecase.dart';

class ExportDatabaseInAccessibleLocationUseCaseImpl
    implements ExportDatabaseInAccessibleLocationUseCase {
  final GlobalDatabaseRepository _repository;

  const ExportDatabaseInAccessibleLocationUseCaseImpl(this._repository);

  @override
  Future<void> execute() {
    return _repository.exportDatabase();
  }
}
