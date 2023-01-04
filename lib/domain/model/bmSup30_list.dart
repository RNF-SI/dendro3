import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30_list.freezed.dart';

@freezed
class BmSup30List with _$BmSup30List {
  const factory BmSup30List({required List<BmSup30> values}) = _BmSup30List;

  const BmSup30List._();

  operator [](final int index) => values[index];

  int get length => values.length;

  BmSup30List addBmSup30(final BmSup30 bmSup30) =>
      copyWith(values: [...values, bmSup30]);

  BmSup30List updateBmSup30(final BmSup30 newBmSup30) {
    return copyWith(
        values: values
            .map((bmSup30) => newBmSup30.idBmSup30 == bmSup30.idBmSup30
                ? newBmSup30
                : bmSup30)
            .toList());
  }

  BmSup30List removeBmSup30ById(final int id) => copyWith(
      values: values.where((bmSup30) => bmSup30.idBmSup30 != id).toList());
}
