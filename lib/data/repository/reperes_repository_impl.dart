import 'package:dendro3/data/datasource/interface/database/reperes_database.dart';
import 'package:dendro3/data/mapper/repere_mapper.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/repository/reperes_repository.dart';

class ReperesRepositoryImpl implements ReperesRepository {
  final ReperesDatabase database;

  const ReperesRepositoryImpl(this.database);

  @override
  Future<Repere> insertRepere(
      final int idPlacette,
      double? azimut,
      double? distance,
      double? diametre,
      String? repere,
      String? observation) async {
    final reperesEntity =
        await database.addRepere(RepereMapper.transformToNewEntityMap(
      idPlacette,
      azimut,
      distance,
      diametre,
      repere,
      observation,
    ));

    return RepereMapper.transformToModel(reperesEntity);
  }

  @override
  Future<Repere> updateRepere(
      final int idRepere,
      final int idPlacette,
      double? azimut,
      double? distance,
      double? diametre,
      String? repere,
      String? observation) async {
    final reperesEntity =
        await database.updateRepere(RepereMapper.transformToEntityMap(
      idRepere,
      idPlacette,
      azimut,
      distance,
      diametre,
      repere,
      observation,
    ));

    return RepereMapper.transformToModel(reperesEntity);
  }
}
