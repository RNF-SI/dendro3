import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/data/mapper/arbre_mapper.dart';
import 'package:dendro3/domain/model/arbre_list.dart';

class ArbreListMapper {
  // static ArbreList transformToModel(final ArbreListEntity entities) {
  //   final values = entities
  //       .map((entity) => ArbreMapper.transformToModel(entity))
  //       .toList();
  //   return ArbreList(values: values);
  // }

  static ArbreList transformFromApiToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => ArbreMapper.transformFromApiToModel(entity))
        .toList();
    return ArbreList(values: values);
  }

  static ArbreListEntity transformToMap(final ArbreList model) =>
      model.values.map((value) => ArbreMapper.transformToMap(value)).toList();
}
