import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'displayable_list.dart';

part 'repere_list.freezed.dart';

@freezed
class RepereList with _$RepereList implements ViewModelObject, DisplayableList {
  const factory RepereList({required List<Repere> values}) = _RepereList;

  const RepereList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static RepereList empty() {
    return const RepereList(values: []);
  }

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
    if (item is Repere) {
      return copyWith(values: [...values, item]);
    }
    throw ArgumentError('Item must be of type Repere');
  }

  @override
  updateItemInList(final dynamic item) {
    if (item is Repere) {
      return copyWith(
          values: values
              .map((repere) => item.idRepere == repere.idRepere ? item : repere)
              .toList());
    }
    throw ArgumentError('Item must be of type Repere');
  }

  @override
  getObjectFromId(final String id) {
    return values.firstWhere((repere) => repere.idRepere == id);
  }

  @override
  String getFirstElementId() {
    return values.first.idRepere;
  }

  @override
  bool isEmpty() {
    return values.isEmpty;
  }

  @override
  RepereList removeItemFromList(final String idRepere) {
    return copyWith(
        values: values.where((repere) => repere.idRepere != idRepere).toList());
  }
}
