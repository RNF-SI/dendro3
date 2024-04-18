import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
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
      coupe,
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

    return arbreUpdated.copyWith(
        arbresMesures: ArbreMesureList(values: updatedMesures));
  }
}
