import 'package:dendro3/presentation/model/dispositifInfo.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dispositifInfo_list.freezed.dart';

@freezed
class DispositifInfoList with _$DispositifInfoList {
  const factory DispositifInfoList({required List<DispositifInfo> values}) =
      _DispositifInfoList;

  const DispositifInfoList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  DispositifInfoList addDispositifInfo(final DispositifInfo dispositifInfo) =>
      copyWith(values: [...values, dispositifInfo]);

  DispositifInfoList updateDispositifInfo(
      final DispositifInfo newDispositifInfo) {
    return copyWith(
        values: values
            .map((dispositifInfo) =>
                newDispositifInfo.dispositif == dispositifInfo.dispositif
                    ? newDispositifInfo
                    : dispositifInfo)
            .toList());
  }
// TODO: Change searching disp in phone db
  // DispositifInfoList filterByDownloaded() => copyWith(
  //     values: values.where((dispositif) => dispositif.isCompleted).toList());

  // DispositifInfoList filterByIncomplete() => copyWith(
  //     values: values.where((dispositif) => !dispositif.isCompleted).toList());
}
