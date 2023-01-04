import 'package:dendro3/data/entity/transects_entity.dart';
import 'package:dendro3/data/mapper/transect_mapper.dart';
import 'package:dendro3/domain/model/transect_list.dart';

class TransectListMapper {
  // static TransectList transformToModel(final TransectListEntity entities) {
  //   final values = entities
  //       .map((entity) => TransectMapper.transformToModel(entity))
  //       .toList();
  //   return TransectList(values: values);
  // }

  static TransectList transformFromApiToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => TransectMapper.transformFromApiToModel(entity))
        .toList();
    return TransectList(values: values);
  }

  static TransectListEntity transformToMap(final TransectList model) =>
      model.values
          .map((value) => TransectMapper.transformToMap(value))
          .toList();
}
