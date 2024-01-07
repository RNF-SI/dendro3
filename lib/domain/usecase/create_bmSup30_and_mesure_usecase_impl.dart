import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';

import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/usecase/create_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';

class CreateBmSup30AndMesureUseCaseImpl
    implements CreateBmSup30AndMesureUseCase {
  final BmsSup30Repository _bmsup30Repository;
  final BmsSup30MesuresRepository _bmsup30MesureRepositoryMesure;

  const CreateBmSup30AndMesureUseCaseImpl(
      this._bmsup30Repository, this._bmsup30MesureRepositoryMesure);

  @override
  Future<BmSup30> execute(
    int idPlacette,
    int? idArbre,
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
    BmSup30 bmsup30 = await _bmsup30Repository.insertBmSup30(
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
        await _bmsup30MesureRepositoryMesure.insertBmSup30Mesure(
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
            observationMesure);

    return bmsup30.copyWith(
        bmsSup30Mesures: BmSup30MesureList(values: [bmsup30Mesure]));
    // return aa;
  }
}
