import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_and_mesure_usecase.dart';

class DeleteBmSup30AndMesureUseCaseImpl
    implements DeleteBmSup30AndMesureUseCase {
  final BmsSup30Repository bmsup30Repository;
  final BmsSup30MesuresRepository bmsup30MesureRepositoryMesure;

  DeleteBmSup30AndMesureUseCaseImpl(
    this.bmsup30Repository,
    this.bmsup30MesureRepositoryMesure,
  );

  @override
  Future<void> execute(String id) async {
    await bmsup30Repository.deleteBmSup30(id);
    await bmsup30MesureRepositoryMesure.deleteBmsSup30Mesure(id);
  }
}
