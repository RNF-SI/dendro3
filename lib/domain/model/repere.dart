import 'package:freezed_annotation/freezed_annotation.dart';

part 'repere.freezed.dart';

@freezed
class Repere with _$Repere {
  const factory Repere(
      {required int idRepere,
      required int idPlacette,
      double? azimut,
      double? distance,
      double? diametre,
      String? repere,
      String? observation}) = _Repere;

  const Repere._();
}
