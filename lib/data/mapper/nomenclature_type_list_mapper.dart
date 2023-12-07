import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:dendro3/data/mapper/nomenclature_type_mapper.dart';
import 'package:dendro3/domain/model/nomenclatureType_list.dart';

class NomenclatureTypeListMapper {
  static NomenclatureTypeList transformFromApiToModel(
      final NomenclatureTypeListEntity entities) {
    final values = entities
        .map((entity) => NomenclatureTypeMapper.transformFromApiToModel(entity))
        .toList();
    return NomenclatureTypeList(values: values);
  }

  static NomenclatureTypeList transformToModel(
      final NomenclatureTypeListEntity entities) {
    final values = entities
        .map((entity) => NomenclatureTypeMapper.transformToModel(entity))
        .toList();
    return NomenclatureTypeList(values: values);
  }
}
