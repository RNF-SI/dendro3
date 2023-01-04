import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:dendro3/data/mapper/regeneration_mapper.dart';
import 'package:dendro3/domain/model/regeneration_list.dart';

class RegenerationListMapper {
  // static RegenerationList transformToModel(final RegenerationListEntity entities) {
  //   final values = entities
  //       .map((entity) => RegenerationMapper.transformToModel(entity))
  //       .toList();
  //   return RegenerationList(values: values);
  // }

  static RegenerationList transformFromApiToModel(
      final List<dynamic> entities) {
    final values = entities
        .map((entity) => RegenerationMapper.transformFromApiToModel(entity))
        .toList();
    return RegenerationList(values: values);
  }

  static RegenerationListEntity transformToMap(final RegenerationList model) =>
      model.values
          .map((value) => RegenerationMapper.transformToMap(value))
          .toList();
}
