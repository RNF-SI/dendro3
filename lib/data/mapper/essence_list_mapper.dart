import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/data/mapper/essence_mapper.dart';
import 'package:dendro3/domain/model/essence_list.dart';

class EssenceListMapper {
  static EssenceList transformFromApiToModel(final EssenceListEntity entities) {
    final values = entities
        .map((entity) => EssenceMapper.transformFromApiToModel(entity))
        .toList();
    return EssenceList(values: values);
  }

  static EssenceList transformToModel(final EssenceListEntity entities) {
    final values = entities
        .map((entity) => EssenceMapper.transformToModel(entity))
        .toList();
    return EssenceList(values: values);
  }
}
