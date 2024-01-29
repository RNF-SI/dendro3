import 'package:dendro3/data/entity/cycles_entity.dart';
import 'package:dendro3/data/mapper/cycle_mapper.dart';
import 'package:dendro3/domain/model/cycle_list.dart';

class CycleListMapper {
  // static CycleList transformToModel(final CycleListEntity entities) {
  //   final values = entities
  //       .map((entity) => CycleMapper.transformToModel(entity))
  //       .toList();
  //   return CycleList(values: values);
  // }

  static CycleList transformFromApiToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => CycleMapper.transformFromApiToModel(entity))
        .toList();
    return CycleList(values: values);
  }

  static CycleList transformFromDBToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => CycleMapper.transformFromDBToModel(entity))
        .toList();
    return CycleList(values: values);
  }

  static CycleListEntity transformToMap(final CycleList model) =>
      model.values.map((value) => CycleMapper.transformToMap(value)).toList();
}
