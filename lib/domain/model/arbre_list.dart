import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/arbre.dart'; // import 'package:clean_architecture_arbre_app/domain/model/arbre_id.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbre_list.freezed.dart';

@freezed
class ArbreList with _$ArbreList implements ViewModelObject, DisplayableList {
  const factory ArbreList({required List<Arbre> values}) = _ArbreList;

  const ArbreList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static ArbreList empty() {
    return const ArbreList(values: []);
  }

  @override
  ArbreList addItemToList(final dynamic item) {
    if (item is Arbre) {
      return copyWith(values: [...values, item]);
    }
    throw ArgumentError('Item must be of type Arbre');
  }

  ArbreList updateArbre(final Arbre newArbre) {
    return copyWith(
        values: values
            .map(
                (arbre) => newArbre.idArbre == arbre.idArbre ? newArbre : arbre)
            .toList());
  }

  ArbreList removeArbreById(final int id) =>
      copyWith(values: values.where((arbre) => arbre.idArbre != id).toList());

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
  Arbre getObjectFromId(final int id) {
    return values.firstWhere((arbre) => arbre.idArbreOrig == id);
  }
}
