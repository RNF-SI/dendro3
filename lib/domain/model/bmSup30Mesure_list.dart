import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart'; // import 'package:clean_architecture_bmSup30Mesure_app/domain/model/bmSup30Mesure_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30Mesure_list.freezed.dart';

@freezed
class BmSup30MesureList with _$BmSup30MesureList {
  const factory BmSup30MesureList({required List<BmSup30Mesure> values}) =
      _BmSup30MesureList;

  const BmSup30MesureList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  BmSup30MesureList addBmSup30Mesure(final BmSup30Mesure bmSup30Mesure) =>
      copyWith(values: [...values, bmSup30Mesure]);

  BmSup30MesureList updateBmSup30Mesure(final BmSup30Mesure newBmSup30Mesure) {
    return copyWith(
        values: values
            .map((bmSup30Mesure) => newBmSup30Mesure.idBmSup30Mesure ==
                    bmSup30Mesure.idBmSup30Mesure
                ? newBmSup30Mesure
                : bmSup30Mesure)
            .toList());
  }

  BmSup30MesureList removeBmSup30MesureById(final int id) => copyWith(
      values: values
          .where((bmSup30Mesure) => bmSup30Mesure.idBmSup30Mesure != id)
          .toList());

  List<Map<String, dynamic>> getValuesMappedFromDisplayedColumnType({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) =>
      values
          .map((value) => value.getValuesMappedFromDisplayedColumnType(
              displayedMesureColumnType: displayedMesureColumnType))
          .toList();

  int? findIndexOfBmSup30Mesure(BmSup30Mesure targetbmSup30Mesure) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].idBmSup30Mesure == targetbmSup30Mesure.idBmSup30Mesure) {
        return i;
      }
    }
    return null; // Retourne null si l'objet n'est pas trouvé
  }

  int? findIndexOfBmSup30MesureFromIdBmSup30Mesure(int targetIdBmSup30Mesure) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].idBmSup30Mesure == targetIdBmSup30Mesure) {
        return i;
      }
    }
    return null; // Retourne null si l'objet n'est pas trouvé
  }

  BmSup30Mesure? getMesureFromIdCycle(idCycle) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].idCycle == idCycle) {
        return values[i];
      }
    }
    return null; // Retourne null si l'objet n'est pas trouvé
  }
}
