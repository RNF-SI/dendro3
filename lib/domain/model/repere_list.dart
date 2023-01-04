import 'package:dendro3/domain/model/repere.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repere_list.freezed.dart';

@freezed
class RepereList with _$RepereList {
  const factory RepereList({required List<Repere> values}) = _RepereList;

  const RepereList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  RepereList addRepere(final Repere repere) =>
      copyWith(values: [...values, repere]);

  RepereList updateRepere(final Repere newRepere) {
    return copyWith(
        values: values
            .map((repere) =>
                newRepere.idRepere == repere.idRepere ? newRepere : repere)
            .toList());
  }

  RepereList removeRepereById(final int id) => copyWith(
      values: values.where((repere) => repere.idRepere != id).toList());
}
