import 'package:dendro3/data/datasource/interface/database/corCyclesPlacettes_database.dart';
import 'package:dendro3/data/entity/corCyclesPlacettes_entity.dart';
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
    final int idCycle,
    final int idPlacette,
    final DateTime? dateReleve,
    final String? dateIntervention,
    final int? annee,
    final String? natureIntervention,
    final String gestionPlacette,
    final int? idNomenclatureCastor,
    final int? idNomenclatureFrottis,
    final int? idNomenclatureBoutis,
    final double? recouvHerbesBasses,
    final double? recouvHerbesHautes,
    final double? recouvBuissons,
    final double? recouvArbres,
    final int? coeff,
    final double? diamLim,
  ) async {
    final corCyclePlacettesEntity = await database
        .addCorCyclePlacette(CorCyclePlacetteMapper.transformToNewEntityMap(
      idCycle,
      idPlacette,
      dateReleve,
      dateIntervention,
      annee,
      natureIntervention,
      gestionPlacette,
      idNomenclatureCastor,
      idNomenclatureFrottis,
      idNomenclatureBoutis,
      recouvHerbesBasses,
      recouvHerbesHautes,
      recouvBuissons,
      recouvArbres,
      coeff,
      diamLim,
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

  @override
  Future<CorCyclePlacette> updateCorCyclePlacette(
    String idCyclePlacette,
    int idCycle,
    int idPlacette,
    DateTime? dateReleve,
    String? dateIntervention,
    int? annee,
    String? natureIntervention,
    String gestionPlacette,
    int? idNomenclatureCastor,
    int? idNomenclatureFrottis,
    int? idNomenclatureBoutis,
    double? recouvHerbesBasses,
    double? recouvHerbesHautes,
    double? recouvBuissons,
    double? recouvArbres,
    int? coeff,
    double? diamLim,
  ) async {
    final corCyclePlacetteEntity = await database
        .updateCorCyclePlacette(CorCyclePlacetteMapper.transformToEntityMap(
      idCyclePlacette,
      idCycle,
      idPlacette,
      dateReleve,
      dateIntervention,
      annee,
      natureIntervention,
      gestionPlacette,
      idNomenclatureCastor,
      idNomenclatureFrottis,
      idNomenclatureBoutis,
      recouvHerbesBasses,
      recouvHerbesHautes,
      recouvBuissons,
      recouvArbres,
      coeff,
      diamLim,
    ));

    return CorCyclePlacetteMapper.transformToModel(corCyclePlacetteEntity);
  }
}
