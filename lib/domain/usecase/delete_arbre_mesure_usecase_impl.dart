import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/usecase/delete_arbre_mesure_usecase.dart';

class DeleteArbreMesureUseCaseImpl implements DeleteArbreMesureUseCase {
  final ArbresMesuresRepository repository;
  final ArbresMesuresRepository arbreMesureRepository;

  DeleteArbreMesureUseCaseImpl(
    this.repository,
    this.arbreMesureRepository,
  );

  @override
  Future<Arbre> execute(
    Arbre arbre,
    String arbreMesureId,
  ) async {
    await repository.deleteArbreMesure(arbreMesureId);

    List<ArbreMesure> updatedMesures = List.from(arbre.arbresMesures!.values);
    // remove from list the element with arbreMesureId
    updatedMesures
        .removeWhere((mesure) => mesure.idArbreMesure == arbreMesureId);

    return arbre.copyWith(
        arbresMesures: ArbreMesureList(values: updatedMesures));
  }
}
