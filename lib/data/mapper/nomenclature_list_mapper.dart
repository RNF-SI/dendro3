import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dendro3/data/mapper/nomenclature_mapper.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';

class NomenclatureListMapper {
  static NomenclatureList transformFromApiToModel(
      final NomenclatureListEntity entities) {
    final values = entities
        .map((entity) => NomenclatureMapper.transformFromApiToModel(entity))
        .toList();
    return NomenclatureList(values: values);
  }

  static NomenclatureList transformToModel(
      final NomenclatureListEntity entities) {
    final values = entities
        .map((entity) => NomenclatureMapper.transformToModel(entity))
        .toList();
    return NomenclatureList(values: values);
  }
}
