import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/usecase/add_bmSup30_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';

class AddBmSup30MesureUseCaseImpl implements AddBmSup30MesureUseCase {
  final BmsSup30Repository _bmsup30Repository;
  final BmsSup30MesuresRepository _bmsup30MesureRepository;

  const AddBmSup30MesureUseCaseImpl(
      this._bmsup30Repository, this._bmsup30MesureRepository);

  @override
  Future<BmSup30> execute(
    BmSup30 bmsup30,
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

    return bmsup30.copyWith(
      bmsSup30Mesures: updatedMesureList,
    );
  }
}
