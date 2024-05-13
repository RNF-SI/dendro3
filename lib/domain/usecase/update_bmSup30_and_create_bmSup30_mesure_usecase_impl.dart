import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_create_bmSup30_mesure_usecase.dart';

class UpdateBmSup30AndCreateBmSup30MesureUseCaseImpl
    implements UpdateBmSup30AndCreateBmSup30MesureUseCase {
  final BmsSup30Repository _bmsup30Repository;
  final BmsSup30MesuresRepository _bmsup30MesureRepository;

  const UpdateBmSup30AndCreateBmSup30MesureUseCaseImpl(
      this._bmsup30Repository, this._bmsup30MesureRepository);

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

    BmSup30Mesure bmsup30Mesure =
        await _bmsup30MesureRepository.insertBmSup30Mesure(
      bmsup30.idBmSup30,
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
      observationMesure,
    );

    var updatedMesureList =
        bmsup30.bmsSup30Mesures!.addBmSup30Mesure(bmsup30Mesure);

    return bmsup30Updated.copyWith(
      bmsSup30Mesures: updatedMesureList,
    );
  }
}
