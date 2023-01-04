import 'package:dendro3/domain/model/transect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transect_list.freezed.dart';

@freezed
class TransectList with _$TransectList {
  const factory TransectList({required List<Transect> values}) = _TransectList;

  const TransectList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  TransectList addTransect(final Transect transect) =>
      copyWith(values: [...values, transect]);

  TransectList updateTransect(final Transect newTransect) {
    return copyWith(
        values: values
            .map((transect) => newTransect.idTransect == transect.idTransect
                ? newTransect
                : transect)
            .toList());
  }

  TransectList removeTransectById(final int id) => copyWith(
      values: values.where((transect) => transect.idTransect != id).toList());

  // TransectList filterByCompleted() => copyWith(
  //     values: values.where((transect) => transect.isCompleted).toList());

  // TransectList filterByIncomplete() => copyWith(
  //     values: values.where((transect) => !transect.isCompleted).toList());
}
