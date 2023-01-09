import 'package:dendro3/data/entity/placettes_entity.dart';
import 'package:dendro3/data/mapper/placette_mapper.dart';
import 'package:dendro3/domain/model/placette_list.dart';

class PlacetteListMapper {
  // static PlacetteList transformToModel(final PlacetteListEntity entities) {
  //   final values = entities
  //       .map((entity) => PlacetteMapper.transformToModel(entity))
  //       .toList();
  //   return PlacetteList(values: values);
  // }

  static PlacetteList transformFromApiToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => PlacetteMapper.transformFromApiToModel(entity))
        .toList();
    return PlacetteList(values: values);
  }

  static PlacetteList transformFromDBToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => PlacetteMapper.transformFromDBToModel(entity))
        .toList();
    return PlacetteList(values: values);
  }

  static PlacetteListEntity transformToMap(final PlacetteList model) =>
      model.values
          .map((value) => PlacetteMapper.transformToMap(value))
          .toList();
}
