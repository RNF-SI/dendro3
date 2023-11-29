import 'package:dendro3/domain/model/bmSup30Mesure.dart';

abstract class BmsSup30MesuresRepository {
  Future<BmSup30Mesure> insertBmSup30Mesure(
    final int idBmSup30Mesure,
    final int idBmSup30,
    final int idCycle,
    final double? diametreIni,
    final double? diametreMed,
    final double? diametreFin,
    final double? diametre130,
    final double longueur,
    final bool? ratioHauteur,
    final double contact,
    final bool chablis,
    final int stadeDurete,
    final int stadeEcorce,
    final String? observation,
  );

  Future<BmSup30Mesure> updateBmSup30Mesure(
    final int idBmSup30Mesure,
    final int idBmSup30,
    final int idCycle,
    final double? diametreIni,
    final double? diametreMed,
    final double? diametreFin,
    final double? diametre130,
    final double longueur,
    final bool? ratioHauteur,
    final double contact,
    final bool chablis,
    final int stadeDurete,
    final int stadeEcorce,
    final String? observation,
  );
}
