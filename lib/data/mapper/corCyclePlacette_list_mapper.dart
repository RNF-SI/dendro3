import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_mapper.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';

class CorCyclePlacetteListMapper {
  // static CorCyclePlacetteList transformToModel(final CorCyclePlacetteListEntity entities) {
  //   final values = entities
  //       .map((entity) => CorCyclePlacetteMapper.transformToModel(entity))
  //       .toList();
  //   return CorCyclePlacetteList(values: values);
  // }

  static CorCyclePlacetteList transformFromApiToModel(
      final List<dynamic> entities) {
    final values = entities
        .map((entity) => CorCyclePlacetteMapper.transformFromApiToModel(entity))
        .toList();
    return CorCyclePlacetteList(values: values);
  }

  static CorCyclePlacetteList transformFromDBToModel(
      final List<dynamic> entities) {
    final values = entities
        .map((entity) => CorCyclePlacetteMapper.transformFromDBToModel(entity))
        .toList();
    return CorCyclePlacetteList(values: values);
  }

  static CorCyclePlacetteListEntity transformToMap(
          final CorCyclePlacetteList model) =>
      model.values
          .map((value) => CorCyclePlacetteMapper.transformToMap(value))
          .toList();
}
