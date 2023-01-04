import 'package:freezed_annotation/freezed_annotation.dart';

part 'regeneration.freezed.dart';

@freezed
class Regeneration with _$Regeneration {
  const factory Regeneration(
      {required int idRegeneration,
      required int idCyclePlacette,
      required int sousPlacette,
      required String codeEssence,
      required double recouvrement,
      required int classe1,
      required int classe2,
      required int classe3,
      required bool taillis,
      required bool abroutissement,
      int? idNomenclatureAbroutissement,
      String? observation}) = _Regeneration;

  const Regeneration._();
}
