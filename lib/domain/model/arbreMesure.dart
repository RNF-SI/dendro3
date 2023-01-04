import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbreMesure.freezed.dart';

@freezed
class ArbreMesure with _$ArbreMesure {
  const factory ArbreMesure({
    required int idArbreMesure,
    required int idArbre,
    required int idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    required bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    required String refCodeEcolo,
    bool? ratioHauteur,
    String? observation,
  }) = _ArbreMesure;

  const ArbreMesure._();
}
