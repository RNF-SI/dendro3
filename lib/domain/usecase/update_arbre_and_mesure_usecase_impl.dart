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
    final int idArbre,
    final int idArbreOrig,
    int idPlacette,
    String codeEssence,
    double azimut,
    double distance,
    bool? taillis,
    String? observation,
    final int idArbreMesure,
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
    Arbre arbre = await _arbreRepository.updateArbre(
      idArbre,
      idArbreOrig,
      idPlacette,
      codeEssence,
      azimut,
      distance,
      taillis,
      observation,
    );

    // if (coupe != null && coupe.isNotEmpty) {
    //   // Récupération de la mesure précédente grace au numCycle
    //   //

    //   ArbreMesure previousCycleMeasure = await _arbreMesureRepository
    //       .getPreviousCycleMeasure(arbre.idArbre, idCycle, numCycle);
    //   if (previousCycleMeasure != null) {
    //     // Mise à jour du champ "coupe" de la mesure précédente
    //     await _arbreMesureRepository.updateLastArbreMesureCoupe(
    //         arbre.idArbre, idCycle, coupe);
    //   }
    // }

    ArbreMesure arbreMesure = await _arbreMesureRepository.updateArbreMesure(
      idArbreMesure,
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
      coupe,
      limite,
      idNomenclatureCodeSanitaire,
      codeEcolo,
      refCodeEcolo,
      ratioHauteur,
      observationMesure,
    );

    return arbre.copyWith(
        arbresMesures: ArbreMesureList(values: [arbreMesure]));
    // return aa;
  }
}
