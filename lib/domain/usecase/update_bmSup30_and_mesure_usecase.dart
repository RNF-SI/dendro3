import 'package:dendro3/domain/model/bmSup30.dart';

abstract class UpdateBmSup30AndMesureUseCase {
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
  );
}
