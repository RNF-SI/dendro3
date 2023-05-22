import 'dart:ffi';

import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette_list.dart';
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
    return this.codeEssence.toString().contains(filter);
  }
}
