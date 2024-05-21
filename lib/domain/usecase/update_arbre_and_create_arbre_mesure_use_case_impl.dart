import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_create_arbre_mesure_use_case.dart';

class UpdateArbreAndCreateArbreMesureUseCaseImpl
    implements UpdateArbreAndCreateArbreMesureUseCase {
  final ArbresRepository _arbreRepository;
  final ArbresMesuresRepository _arbreMesureRepository;

  const UpdateArbreAndCreateArbreMesureUseCaseImpl(
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
      coupe,
      limite,
      idNomenclatureCodeSanitaire,
      codeEcolo,
      refCodeEcolo,
      ratioHauteur,
      observationMesure,
    );

    var updatedMesureList = arbre.arbresMesures!.addArbreMesure(arbreMesure);

    return arbreUpdated.copyWith(
      arbresMesures: updatedMesureList,
    );
  }
}
