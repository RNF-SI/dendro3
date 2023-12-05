import 'package:dendro3/domain/repository/reperes_repository.dart';
import 'package:dendro3/domain/usecase/delete_repere_usecase.dart';

class DeleteRepereUseCaseImpl implements DeleteRepereUseCase {
  final ReperesRepository _repereRepository;

  DeleteRepereUseCaseImpl(this._repereRepository);

  @override
  Future<void> execute(int id) async {
    await _repereRepository.deleteRepere(id);
  }
}
