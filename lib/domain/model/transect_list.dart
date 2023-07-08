import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transect_list.freezed.dart';

@freezed
class TransectList
    with _$TransectList
    implements ViewModelObject, DisplayableList {
  const factory TransectList({required List<Transect> values}) = _TransectList;

  const TransectList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static TransectList empty() {
    return const TransectList(values: []);
  }

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

  @override
  List<Map<String, dynamic>> getObjectMapped({
    DisplayedColumnType displayedColumnType = DisplayedColumnType.all,
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) =>
      values.map((value) {
        return value.getValuesMappedFromDisplayedColumnType(
            displayedColumnType: displayedColumnType,
            displayedMesureColumnType: displayedMesureColumnType);
      }).toList();

  @override
  addItemToList(final dynamic item) {
    if (item is Transect) {
      return copyWith(values: [...values, item]);
    }
    throw ArgumentError('Item must be of type Transect');
  }

  // TransectList filterByCompleted() => copyWith(
  //     values: values.where((transect) => transect.isCompleted).toList());

  // TransectList filterByIncomplete() => copyWith(
  //     values: values.where((transect) => !transect.isCompleted).toList());
}
