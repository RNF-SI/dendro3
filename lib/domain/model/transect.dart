import 'package:freezed_annotation/freezed_annotation.dart';

part 'transect.freezed.dart';

@freezed
class Transect with _$Transect {
  const factory Transect({
    required int idTransect,
    required int idCyclePlacette,
    required int idTransectOrig,
    required String codeEssence,
    required String refTransect,
    double? distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    required double diametre,
    double? diametre130,
    bool? ratioHauteur,
    required bool contact,
    required double angle,
    required bool chablis,
    required int stadeDurete,
    required int stadeEcorce,
    String? observation,
  }) = _Transect;

  const Transect._();
}
