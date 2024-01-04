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
    int arbreMesureId,
    int arbreId,
    final int? idCycle,
    int? numCycle,
  ) async {
    await repository.deleteArbreMesure(arbreMesureId);

    ArbreMesure? updatedPreviousCycleMeasure;

    // Récupération de la mesure précédente grace au numCycle
    ArbreMesure previousCycleMeasure =
        await arbreMesureRepository.getPreviousCycleMeasure(
      arbreId,
      idCycle,
      numCycle,
    );
    if (previousCycleMeasure != null) {
      // Mise à jour du champ "coupe" de la mesure précédente
      updatedPreviousCycleMeasure = await arbreMesureRepository
          .updateLastArbreMesureCoupe(previousCycleMeasure.idArbreMesure, null);
    }

    List<ArbreMesure> updatedMesures = List.from(arbre.arbresMesures!.values);
    // remove from list the element with arbreMesureId
    updatedMesures
        .removeWhere((mesure) => mesure.idArbreMesure == arbreMesureId);

    // Mise à jour de la liste des mesures
    List<ArbreMesure> updatedMesuresWithPrevious = updatedMesures.map((mesure) {
      // Remplace la mesure existante si elle correspond à la mesure précédente mise à jour
      if (updatedPreviousCycleMeasure != null &&
          mesure.idArbreMesure == updatedPreviousCycleMeasure.idArbreMesure) {
        return updatedPreviousCycleMeasure;
      }
      return mesure;
    }).toList();

    return arbre.copyWith(
        arbresMesures: ArbreMesureList(values: updatedMesuresWithPrevious));
  }
}
