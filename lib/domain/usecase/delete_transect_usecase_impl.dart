import 'package:dendro3/domain/repository/transects_repository.dart';
import 'package:dendro3/domain/usecase/delete_transect_usecase.dart';

class DeleteTransectUseCaseImpl implements DeleteTransectUseCase {
  final TransectsRepository _transectRepository;

  DeleteTransectUseCaseImpl(this._transectRepository);

  @override
  Future<void> execute(int transectId) async {
    await _transectRepository.deleteTransect(transectId);
  }
}
