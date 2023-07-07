import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'regeneration_list.freezed.dart';

@freezed
class RegenerationList with _$RegenerationList implements DisplayableList {
  const factory RegenerationList({required List<Regeneration> values}) =
      _RegenerationList;

  const RegenerationList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static RegenerationList empty() {
    return const RegenerationList(values: []);
  }

  RegenerationList addRegeneration(final Regeneration regeneration) =>
      copyWith(values: [...values, regeneration]);

  RegenerationList updateRegeneration(final Regeneration newRegeneration) {
    return copyWith(
        values: values
            .map((regeneration) =>
                newRegeneration.idRegeneration == regeneration.idRegeneration
                    ? newRegeneration
                    : regeneration)
            .toList());
  }

  RegenerationList removeRegenerationById(final int id) => copyWith(
      values: values
          .where((regeneration) => regeneration.idRegeneration != id)
          .toList());

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
}
