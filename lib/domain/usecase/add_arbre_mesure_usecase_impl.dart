import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/usecase/add_arbre_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';

class AddArbreMesureUseCaseImpl implements AddArbreMesureUseCase {
  final ArbresRepository _arbreRepository;
  final ArbresMesuresRepository _arbreMesureRepository;

  const AddArbreMesureUseCaseImpl(
      this._arbreRepository, this._arbreMesureRepository);

  @override
  Future<Arbre> execute(
    Arbre arbre,
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

    ArbreMesure arbreMesure = await _arbreMesureRepository.insertArbreMesure(
      arbre.idArbre,
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

    // Mise à jour de la liste des mesures
    List<ArbreMesure> updatedMesures =
        arbre.arbresMesures!.values.map((mesure) {
      // Remplace la mesure existante si elle correspond à la mesure précédente mise à jour
      if (updatedPreviousCycleMeasure != null &&
          mesure.idArbreMesure == updatedPreviousCycleMeasure.idArbreMesure) {
        return updatedPreviousCycleMeasure;
      }
      return mesure;
    }).toList();

    // Ajoute la nouvelle mesure à la liste
    updatedMesures.add(arbreMesure);

    return arbre.copyWith(
      arbresMesures: ArbreMesureList(values: updatedMesures),
    );

    // return arbre.copyWith(
    //     arbresMesures: ArbreMesureList(values: [arbreMesure, ...arbre.arbresMesures]));
    // return aa;
  }
}
