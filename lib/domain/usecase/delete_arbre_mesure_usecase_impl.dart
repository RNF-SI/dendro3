import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/usecase/delete_arbre_mesure_usecase.dart';

class DeleteArbreMesureUseCaseImpl implements DeleteArbreMesureUseCase {
  final ArbresMesuresRepository repository;

  DeleteArbreMesureUseCaseImpl(this.repository);

  @override
  Future<void> execute(int arbreMesureId) async {
    await repository.deleteArbreMesure(arbreMesureId);
  }
}
