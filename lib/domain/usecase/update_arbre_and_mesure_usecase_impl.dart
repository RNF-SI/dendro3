import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_mesure_usecase.dart';

class UpdateArbreAndMesureUseCaseImpl implements UpdateArbreAndMesureUseCase {
  final ArbresRepository _arbreRepository;
  final ArbresMesuresRepository _arbreMesureRepository;

  const UpdateArbreAndMesureUseCaseImpl(
      this._arbreRepository, this._arbreMesureRepository);

  @override
  Future<Arbre> execute(
    Arbre arbre,
    final String idArbre,
    final int idArbreOrig,
    int idPlacette,
    String codeEssence,
    double azimut,
    double distance,
    bool? taillis,
    String? observation,
    final String idArbreMesure,
    final int? idCycle,
    int? numCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  ) async {
    Arbre arbreUpdated = await _arbreRepository.updateArbre(
      idArbre,
      idArbreOrig,
      idPlacette,
      codeEssence,
      azimut,
      distance,
      taillis,
      observation,
    );

    ArbreMesure? updatedPreviousCycleMeasure;
    if (coupe != null && coupe.isNotEmpty) {
      // Récupération de la mesure précédente grace au numCycle
      ArbreMesure previousCycleMeasure = await _arbreMesureRepository
          .getPreviousCycleMeasure(arbre.idArbre, idCycle, numCycle);
      if (previousCycleMeasure != null) {
        // Mise à jour du champ "coupe" de la mesure précédente
        updatedPreviousCycleMeasure =
            await _arbreMesureRepository.updateLastArbreMesureCoupe(
                previousCycleMeasure.idArbreMesure, coupe);
      }
    }

    ArbreMesure arbreMesureUpdated =
        await _arbreMesureRepository.updateArbreMesure(
      idArbreMesure,
      arbreUpdated.idArbre,
      idCycle,
      diametre1,
      diametre2,
      type,
      hauteurTotale,
      hauteurBranche,
      stadeDurete,
      stadeEcorce,
      liane,
      diametreLiane,
      '',
      limite,
      idNomenclatureCodeSanitaire,
      codeEcolo,
      refCodeEcolo,
      ratioHauteur,
      observationMesure,
    );

    int mesureIndex = arbre.arbresMesures!.values
        .indexWhere((mesure) => mesure.idArbreMesure == idArbreMesure);

    // Créer une nouvelle liste des mesures avec la mesure mise à jour
    List<ArbreMesure> updatedMesures = List.from(arbre.arbresMesures!.values);
    if (mesureIndex != -1) {
      updatedMesures[mesureIndex] = arbreMesureUpdated;
    }

    // Mise à jour de la liste des mesures
    List<ArbreMesure> updatedMesuresWithPrevious = updatedMesures.map((mesure) {
      // Remplace la mesure existante si elle correspond à la mesure précédente mise à jour
      if (updatedPreviousCycleMeasure != null &&
          mesure.idArbreMesure == updatedPreviousCycleMeasure.idArbreMesure) {
        return updatedPreviousCycleMeasure;
      }
      return mesure;
    }).toList();

    return arbreUpdated.copyWith(
        arbresMesures: ArbreMesureList(values: updatedMesuresWithPrevious));
  }
}
