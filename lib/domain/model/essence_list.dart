import 'package:dendro3/domain/model/essence.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'essence_list.freezed.dart';

@freezed
class EssenceList with _$EssenceList {
  const factory EssenceList({required List<Essence> values}) = _EssenceList;

  const EssenceList._();

  operator [](final int index) => values[index];

  int get length => values.length;
}
