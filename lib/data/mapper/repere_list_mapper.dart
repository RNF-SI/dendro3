import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:dendro3/data/mapper/repere_mapper.dart';
import 'package:dendro3/domain/model/repere_list.dart';

class RepereListMapper {
  // static RepereList transformToModel(final RepereListEntity entities) {
  //   final values = entities
  //       .map((entity) => RepereMapper.transformToModel(entity))
  //       .toList();
  //   return RepereList(values: values);
  // }

  static RepereList transformFromApiToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => RepereMapper.transformFromApiToModel(entity))
        .toList();
    return RepereList(values: values);
  }

  static RepereList transformFromDBToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => RepereMapper.transformFromDBToModel(entity))
        .toList();
    return RepereList(values: values);
  }

  static RepereListEntity transformToMap(final RepereList model) =>
      model.values.map((value) => RepereMapper.transformToMap(value)).toList();
}
