import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/arbreMesure.dart'; // import 'package:clean_architecture_arbreMesure_app/domain/model/arbreMesure_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbreMesure_list.freezed.dart';

@freezed
class ArbreMesureList with _$ArbreMesureList {
  const factory ArbreMesureList({required List<ArbreMesure> values}) =
      _ArbreMesureList;

  const ArbreMesureList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  ArbreMesureList addArbreMesure(final ArbreMesure arbreMesure) =>
      copyWith(values: [...values, arbreMesure]);

  ArbreMesureList updateArbreMesure(final ArbreMesure newArbreMesure) {
    return copyWith(
        values: values
            .map((arbreMesure) =>
                newArbreMesure.idArbreMesure == arbreMesure.idArbreMesure
                    ? newArbreMesure
                    : arbreMesure)
            .toList());
  }

  ArbreMesureList removeArbreMesureById(final int id) => copyWith(
      values: values
          .where((arbreMesure) => arbreMesure.idArbreMesure != id)
          .toList());

  List<Map<String, dynamic>> getValuesMappedFromDisplayedColumnType({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) =>
      values
          .map((value) => value.getValuesMappedFromDisplayedColumnType(
              displayedMesureColumnType: displayedMesureColumnType))
          .toList();

  int? findIndexOfArbreMesure(ArbreMesure targetArbreMesure) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].idArbreMesure == targetArbreMesure.idArbreMesure) {
        return i;
      }
    }
    return null; // Retourne null si l'objet n'est pas trouvé
  }

  int? findIndexOfArbreMesureFromIdArbreMesure(int targetIdArbreMesure) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].idArbreMesure == targetIdArbreMesure) {
        return i;
      }
    }
    return null; // Retourne null si l'objet n'est pas trouvé
  }
}
