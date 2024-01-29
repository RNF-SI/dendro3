import 'package:dendro3/data/data_module.dart';
import 'package:dendro3/data/datasource/interface/database/corCyclesPlacettes_database.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_mapper.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/repository/regenerations_repository.dart';
import 'package:dendro3/domain/repository/transects_repository.dart';

class CorCyclesPlacettesRepositoryImpl implements CorCyclesPlacettesRepository {
  final CorCyclesPlacettesDatabase database;
  final TransectsRepository transectsRepository;
  final RegenerationsRepository regenerationsRepository;
  final LocalStorageRepository _localStorageRepository;

  const CorCyclesPlacettesRepositoryImpl(
    this.database,
    this.transectsRepository,
    this.regenerationsRepository,
    this._localStorageRepository,
  );

  @override
  Future<CorCyclePlacette> insertCorCyclePlacette(
    final int id_cycle,
    final int id_placette,
    final DateTime? date_releve,
    final String? date_intervention,
    final int? annee,
    final String? nature_intervention,
    final String gestion_placette,
    final int? id_nomenclature_castor,
    final int? id_nomenclature_frottis,
    final int? id_nomenclature_boutis,
    final double? recouv_herbes_basses,
    final double? recouv_herbes_hautes,
    final double? recouv_buissons,
    final double? recouv_arbres,
  ) async {
    final corCyclePlacettesEntity = await database
        .addCorCyclePlacette(CorCyclePlacetteMapper.transformToNewEntityMap(
      id_cycle,
      id_placette,
      date_releve,
      date_intervention,
      annee,
      nature_intervention,
      gestion_placette,
      id_nomenclature_castor,
      id_nomenclature_frottis,
      id_nomenclature_boutis,
      recouv_herbes_basses,
      recouv_herbes_hautes,
      recouv_buissons,
      recouv_arbres,
    ));

    return CorCyclePlacetteMapper.transformToModel(corCyclePlacettesEntity);
  }

  @override
  Future<List<String>> getCorCyclePlacetteIdsForPlacette(int placetteId) {
    return database.getCorCyclePlacetteIdsForPlacette(placetteId);
  }

  @override
  Future<void> deleteCorCyclePlacetteTransectAndRege(
      String corCyclePlacetteId) async {
    await transectsRepository
        .deleteTransectsForCorCyclePlacette(corCyclePlacetteId);
    await regenerationsRepository
        .deleteRegenerationsForCorCyclePlacette(corCyclePlacetteId);

    _localStorageRepository
        .removeFromInProgressCorCyclePlacette(corCyclePlacetteId);

    await database.deleteCorCyclePlacette(corCyclePlacetteId);
  }
}
