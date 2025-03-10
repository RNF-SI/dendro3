import 'package:freezed_annotation/freezed_annotation.dart';

part 'essence.freezed.dart';

@freezed
class Essence with _$Essence {
  const factory Essence({
    required String codeEssence,
    int? cdNom,
    required String nom,
    String? nomLatin,
    String? essReg,
    String? couleur,
  }) = _Essence;

  const Essence._();

  bool essenceFilterByCodeEssenceOrNom(String filter) {
    return (codeEssence + nom).toLowerCase().contains(filter.toLowerCase());
  }
}
