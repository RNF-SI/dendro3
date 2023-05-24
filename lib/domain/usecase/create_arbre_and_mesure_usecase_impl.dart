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
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';

class CreateArbreAndMesureUseCaseImpl implements CreateArbreAndMesureUseCase {
  final ArbresRepository _arbreRepository;
  final ArbresMesuresRepository _arbreMesureRepositoryMesure;

  const CreateArbreAndMesureUseCaseImpl(
      this._arbreRepository, this._arbreMesureRepositoryMesure);

  @override
  Future<Arbre> execute(
    // int idArbreOrig,
    int idPlacette,
    String codeEssence,
    double azimut,
    double distance,
    bool? taillis,
    String? observation,
    final int? idCycle,
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
    Arbre arbre = await _arbreRepository.insertArbre(
      // idArbreOrig,
      idPlacette,
      codeEssence,
      azimut,
      distance,
      taillis,
      observation,
    );

    ArbreMesure arbreMesure =
        await _arbreMesureRepositoryMesure.insertArbreMesure(
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
