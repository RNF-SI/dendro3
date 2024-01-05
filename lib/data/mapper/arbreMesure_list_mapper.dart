import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/mapper/arbreMesure_mapper.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';

class ArbreMesureListMapper {
  // static ArbreMesureList transformToModel(final ArbreMesureListEntity entities) {
  //   final values = entities
  //       .map((entity) => ArbreMesureMapper.transformToModel(entity))
  //       .toList();
  //   return ArbreMesureList(values: values);
  // }

  static ArbreMesureList transformFromApiToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => ArbreMesureMapper.transformFromApiToModel(entity))
        .toList();
    return ArbreMesureList(values: values);
  }

  static ArbreMesureList transformFromDBToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => ArbreMesureMapper.transformFromDBToModel(entity))
        .toList();
    return ArbreMesureList(values: values);
  }

  static ArbreMesureListEntity transformToMap(final ArbreMesureList model) =>
      model.values
          .map((value) => ArbreMesureMapper.transformToMap(value))
          .toList();
}
