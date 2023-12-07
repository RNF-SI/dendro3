import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/domain/model/bmSup30.dart';

abstract class CreateBmSup30AndMesureUseCase {
  Future<BmSup30> execute(
    int idPlacette,
    int idArbre,
    String codeEssence,
    double azimut,
    double distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    String? observation,
    int idBmSup30,
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
  );
}
