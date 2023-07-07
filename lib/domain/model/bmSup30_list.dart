import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30_list.freezed.dart';

@freezed
class BmSup30List
    with _$BmSup30List
    implements ViewModelObject, DisplayableList {
  const factory BmSup30List({required List<BmSup30> values}) = _BmSup30List;

  const BmSup30List._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static BmSup30List empty() {
    return const BmSup30List(values: []);
  }

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

  BmSup30List addItemToList(final dynamic item) {
    if (item is BmSup30) {
      return copyWith(values: [...values, item]);
    }
    throw ArgumentError('Item must be of type Arbre');
  }

  @override
  List<Map<String, dynamic>> getObjectMapped(
          {DisplayedColumnType displayedColumnType = DisplayedColumnType.all,
          DisplayedColumnType displayedMesureColumnType =
              DisplayedColumnType.all}) =>
      values.map((value) {
        return value.getValuesMappedFromDisplayedColumnType(
            displayedColumnType: displayedColumnType,
            displayedMesureColumnType: displayedMesureColumnType);
      }).toList();
}
