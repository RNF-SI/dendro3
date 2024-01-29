import 'package:dendro3/domain/repository/regenerations_repository.dart';
import 'package:dendro3/domain/usecase/delete_regeneration_usecase.dart';

class DeleteRegenerationUseCaseImpl implements DeleteRegenerationUseCase {
  final RegenerationsRepository _regenerationRepository;

  DeleteRegenerationUseCaseImpl(this._regenerationRepository);

  @override
  Future<void> execute(String regenerationId) async {
    await _regenerationRepository.deleteRegeneration(regenerationId);
  }
}
