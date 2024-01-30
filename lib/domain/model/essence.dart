
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

  bool essenceFilterByCodeEssence(String filter) {
    return codeEssence.toLowerCase().contains(filter.toLowerCase());
  }
}
