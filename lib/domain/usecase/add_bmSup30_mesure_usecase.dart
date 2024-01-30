import 'package:dendro3/domain/model/bmSup30.dart';

abstract class AddBmSup30MesureUseCase {
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
  );
}
