import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/data/mapper/bmSup30_mapper.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';

class BmSup30ListMapper {
  // static BmSup30List transformToModel(final BmSup30ListEntity entities) {
  //   final values = entities
  //       .map((entity) => BmSup30Mapper.transformToModel(entity))
  //       .toList();
  //   return BmSup30List(values: values);
  // }

  static BmSup30List transformFromApiToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => BmSup30Mapper.transformFromApiToModel(entity))
        .toList();
    return BmSup30List(values: values);
  }

  static BmSup30List transformFromDBToModel(final List<dynamic> entities) {
    final values = entities
        .map((entity) => BmSup30Mapper.transformFromDBToModel(entity))
        .toList();
    return BmSup30List(values: values);
  }

  static BmSup30ListEntity transformToMap(final BmSup30List model) =>
      model.values.map((value) => BmSup30Mapper.transformToMap(value)).toList();
}
