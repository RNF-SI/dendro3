import 'package:dendro3/data/datasource/interface/database/transects_database.dart';
import 'package:dendro3/data/mapper/transect_mapper.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/transects_repository.dart';

class TransectsRepositoryImpl implements TransectsRepository {
  final TransectsDatabase database;

  const TransectsRepositoryImpl(this.database);

  @override
  Future<Transect> insertTransect(
    final int idCyclePlacette,
    final String codeEssence,
    final String refTransect,
    double? distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    final double diametre,
    double? diametre130,
    bool? ratioHauteur,
    final bool contact,
    final double angle,
    final bool chablis,
    final int stadeDurete,
    final int stadeEcorce,
    String? observation,
  ) async {
    final transectsEntity =
        await database.addTransect(TransectMapper.transformToNewEntityMap(
      idCyclePlacette,
      codeEssence,
      refTransect,
      distance,
      orientation,
      azimutSouche,
      distanceSouche,
      diametre,
      diametre130,
      ratioHauteur,
      contact,
      angle,
      chablis,
      stadeDurete,
      stadeEcorce,
      observation,
    ));

    return TransectMapper.transformToModel(transectsEntity);
  }

  @override
  Future<Transect> updateTransect(
    final idTransect,
    final int idCyclePlacette,
    final int idTransectOrig,
    final String codeEssence,
    final String refTransect,
    double? distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    final double diametre,
    double? diametre130,
    bool? ratioHauteur,
    final bool contact,
    final double angle,
    final bool chablis,
    final int stadeDurete,
    final int stadeEcorce,
    String? observation,
  ) async {
    final transectsEntity =
        await database.updateTransect(TransectMapper.transformToEntityMap(
      idTransect,
      idCyclePlacette,
      idTransectOrig,
      codeEssence,
      refTransect,
      distance,
      orientation,
      azimutSouche,
      distanceSouche,
      diametre,
      diametre130,
      ratioHauteur,
      contact,
      angle,
      chablis,
      stadeDurete,
      stadeEcorce,
      observation,
    ));

    return TransectMapper.transformToModel(transectsEntity);
  }

  @override
  Future<void> deleteTransect(final int idTransect) async {
    await database.deleteTransect(idTransect);
  }

  @override
  Future<void> deleteTransectsForCorCyclePlacette(
      final int idCyclePlacette) async {
    await database.deleteTransectsForCorCyclePlacette(idCyclePlacette);
  }
}
