import 'package:dendro3/domain/model/nomenclatureType.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nomenclatureType_list.freezed.dart';

@freezed
class NomenclatureTypeList with _$NomenclatureTypeList {
  const factory NomenclatureTypeList({required List<NomenclatureType> values}) =
      _NomenclatureTypeList;

  const NomenclatureTypeList._();

  operator [](final int index) => values[index];

  int get length => values.length;
}
