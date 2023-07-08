import 'package:dendro3/domain/model/transect.dart';

abstract class TransectsRepository {
  Future<Transect> insertTransect(
    final int idCyclePlacette,
    final String codeEssence,
    final String refTransect,
    double? distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    final double diametre,
    double? diametre130,
    bool? ratioHauteur,
    final bool contact,
    final double angle,
    final bool chablis,
    final int stadeDurete,
    final int stadeEcorce,
    String? observation,
  );
}
