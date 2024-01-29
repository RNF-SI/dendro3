import 'package:dendro3/domain/model/transect.dart';

abstract class TransectsRepository {
  Future<Transect> insertTransect(
    final String idCyclePlacette,
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

  Future<Transect> updateTransect(
    final String idTransect,
    final String idCyclePlacette,
    final int idTransectOrig,
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

  Future<void> deleteTransect(final String idTransect);

  Future<void> deleteTransectsForCorCyclePlacette(String corCyclePlacetteId);
}
