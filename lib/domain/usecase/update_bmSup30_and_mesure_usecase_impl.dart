import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';

import 'package:dendro3/domain/usecase/update_bmSup30_and_mesure_usecase.dart';

class UpdateBmSup30AndMesureUseCaseImpl
    implements UpdateBmSup30AndMesureUseCase {
  final BmsSup30Repository _bmsup30Repository;
  final BmsSup30MesuresRepository _bmsup30MesureRepositoryMesure;

  const UpdateBmSup30AndMesureUseCaseImpl(
      this._bmsup30Repository, this._bmsup30MesureRepositoryMesure);

  @override
  Future<BmSup30> execute(
    BmSup30 bmsup30,
    String idBmSup30,
    int idBmSup30Orig,
    int idPlacette,
    int idArbre,
    String codeEssence,
    double azimut,
    double distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    String? observation,
    String idBmSup30Mesure,
    int idCycle,
    double? diametreIni,
    double? diametreMed,
    double? diametreFin,
    double? diametre130,
    double longueur,
    bool? ratioHauteur,
    double contact,
    bool chablis,
    int stadeDurete,
    int stadeEcorce,
    String? observationMesure,
  ) async {
    BmSup30 bmsup30Updated = await _bmsup30Repository.updateBmSup30(
      idBmSup30,
      idBmSup30Orig,
      idPlacette,
      idArbre,
      codeEssence,
      azimut,
      distance,
      orientation,
      azimutSouche,
      distanceSouche,
      observation,
    );

    BmSup30Mesure bmsup30MesureUpdated =
        await _bmsup30MesureRepositoryMesure.updateBmSup30Mesure(
            idBmSup30Mesure,
            bmsup30Updated.idBmSup30,
            idCycle,
            diametreIni,
            diametreMed,
            diametreFin,
            diametre130,
            longueur,
            ratioHauteur,
            contact,
            chablis,
            stadeDurete,
            stadeEcorce,
            observationMesure);

    int mesureIndex = bmsup30.bmsSup30Mesures!.values
        .indexWhere((mesure) => mesure.idBmSup30Mesure == idBmSup30Mesure);

    // Créer une nouvelle liste des mesures avec la mesure mise à jour
    List<BmSup30Mesure> updatedMesures =
        List.from(bmsup30.bmsSup30Mesures!.values);
    if (mesureIndex != -1) {
      updatedMesures[mesureIndex] = bmsup30MesureUpdated;
    }

    return bmsup30Updated.copyWith(
        bmsSup30Mesures: BmSup30MesureList(values: updatedMesures));
  }
}
