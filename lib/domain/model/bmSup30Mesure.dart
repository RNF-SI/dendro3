import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30Mesure.freezed.dart';

@freezed
class BmSup30Mesure with _$BmSup30Mesure {
  const factory BmSup30Mesure(
      {required int idBmSup30Mesure,
      required int idBmSup30,
      required int idCycle,
      double? diametreIni,
      double? diametreMed,
      double? diametreFin,
      double? diametre130,
      required double longueur,
      bool? ratioHauteur,
      required double contact,
      required bool chablis,
      required int stadeDurete,
      required int stadeEcorce,
      String? observation}) = _BmSup30Mesure;

  const BmSup30Mesure._();
}
