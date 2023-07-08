import 'package:dendro3/data/datasource/interface/database/regenerations_database.dart';
import 'package:dendro3/data/mapper/regeneration_mapper.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/regenerations_repository.dart';

class RegenerationsRepositoryImpl implements RegenerationsRepository {
  final RegenerationsDatabase database;

  const RegenerationsRepositoryImpl(this.database);

  @override
  Future<Regeneration> insertRegeneration(
      // final int idRegeneration,
      final int idCyclePlacette,
      final int sousPlacette,
      final String codeEssence,
      final double recouvrement,
      final int classe1,
      final int classe2,
      final int classe3,
      final bool taillis,
      final bool abroutissement,
      int? idNomenclatureAbroutissement,
      String? observation) async {
    final regenerationsEntity = await database.addRegeneration(
        RegenerationMapper.transformToNewEntityMap(
            idCyclePlacette,
            sousPlacette,
            codeEssence,
            recouvrement,
            classe1,
            classe2,
            classe3,
            taillis,
            abroutissement,
            idNomenclatureAbroutissement,
            observation));

    return RegenerationMapper.transformToModel(regenerationsEntity);
  }
}
