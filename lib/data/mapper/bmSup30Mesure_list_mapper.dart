import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';
import 'package:dendro3/data/mapper/bmSup30Mesure_mapper.dart';
import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';

class BmSup30MesureListMapper {
  // static BmSup30MesureList transformToModel(final BmSup30MesureListEntity entities) {
  //   final values = entities
  //       .map((entity) => BmSup30MesureMapper.transformToModel(entity))
  //       .toList();
  //   return BmSup30MesureList(values: values);
  // }

  static BmSup30MesureList transformFromApiToModel(
      final List<dynamic> entities) {
    final values = entities
        .map((entity) => BmSup30MesureMapper.transformFromApiToModel(entity))
        .toList();
    return BmSup30MesureList(values: values);
  }

  static BmSup30MesureListEntity transformToMap(
          final BmSup30MesureList model) =>
      model.values
          .map((value) => BmSup30MesureMapper.transformToMap(value))
          .toList();
}
