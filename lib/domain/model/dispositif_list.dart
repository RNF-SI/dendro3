import 'package:dendro3/domain/model/dispositif.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dispositif_list.freezed.dart';

@freezed
class DispositifList with _$DispositifList {
  const factory DispositifList({required List<Dispositif> values}) =
      _DispositifList;

  const DispositifList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  DispositifList addDispositif(final Dispositif dispositif) =>
      copyWith(values: [...values, dispositif]);

  DispositifList updateDispositif(final Dispositif newDispositif) {
    return copyWith(
        values: values
            .map((dispositif) =>
                newDispositif.id == dispositif.id ? newDispositif : dispositif)
            .toList());
  }

  DispositifList removeDispositifById(final int id) => copyWith(
      values: values.where((dispositif) => dispositif.id != id).toList());

  // DispositifList filterByCompleted() => copyWith(
  //     values: values.where((dispositif) => dispositif.isCompleted).toList());

  // DispositifList filterByIncomplete() => copyWith(
  //     values: values.where((dispositif) => !dispositif.isCompleted).toList());
}
