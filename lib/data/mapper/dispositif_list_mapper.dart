import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/mapper/dispositif_mapper.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';

class DispositifListMapper {
  static DispositifList transformToModel(final DispositifListEntity entities) {
    final values = entities
        .map((entity) => DispositifMapper.transformToModel(entity))
        .toList();
    return DispositifList(values: values);
  }

  static DispositifList transformFromApiToModel(
      final DispositifListEntity entities) {
    final values = entities
        .map((entity) => DispositifMapper.transformFromApiToModel(entity))
        .toList();
    return DispositifList(values: values);
  }

  static DispositifListEntity transformToMap(final DispositifList model) =>
      model.values
          .map((value) => DispositifMapper.transformToMap(value))
          .toList();
}
