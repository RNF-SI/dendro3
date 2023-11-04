import 'package:dendro3/domain/model/nomenclature.dart';
// import 'package:clean_architecture_todo_app/domain/model/todo_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nomenclature_list.freezed.dart';

@freezed
class NomenclatureList with _$NomenclatureList {
  const factory NomenclatureList({required List<Nomenclature> values}) =
      _NomenclatureList;

  const NomenclatureList._();

  operator [](final int index) => values[index];

  int get length => values.length;
}
