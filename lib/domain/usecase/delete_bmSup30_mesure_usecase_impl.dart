import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_mesure_usecase.dart';

class DeleteBmSup30AndMesureUseCaseImpl implements DeleteBmSup30MesureUseCase {
  final BmsSup30MesuresRepository bmsup30MesureRepositoryMesure;

  DeleteBmSup30AndMesureUseCaseImpl(
    this.bmsup30MesureRepositoryMesure,
  );

  @override
  Future<void> execute(int id) async {
    await bmsup30MesureRepositoryMesure.deleteBmsSup30Mesure(id);
  }
}
