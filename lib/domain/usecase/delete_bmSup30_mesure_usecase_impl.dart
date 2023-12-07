import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_mesure_usecase.dart';

class DeleteBmSup30MesureUseCaseImpl implements DeleteBmSup30MesureUseCase {
  final BmsSup30MesuresRepository _bmSup30MesuresRepository;

  DeleteBmSup30MesureUseCaseImpl(this._bmSup30MesuresRepository);

  @override
  Future<void> execute(int id) async {
    await _bmSup30MesuresRepository.deleteBmsSup30Mesure(id);
  }
}
