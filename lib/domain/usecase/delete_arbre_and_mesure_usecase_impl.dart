import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/usecase/delete_arbre_and_mesure_usecase.dart';

class DeleteArbreAndMesureUseCaseImpl implements DeleteArbreAndMesureUseCase {
  final ArbresRepository arbreRepository;
  final ArbresMesuresRepository arbreMesureRepository;

  DeleteArbreAndMesureUseCaseImpl(
    this.arbreRepository,
    this.arbreMesureRepository,
  );

  @override
  Future<void> execute(int arbreId) async {
    await arbreRepository.deleteArbre(arbreId);
    await arbreMesureRepository.deleteArbreMesureFromIdArbre(arbreId);
  }
}
