import 'package:dendro3/data/datasource/interface/database/placettes_database.dart';
import 'package:dendro3/data/mapper/placette_mapper.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';
import 'package:dendro3/domain/repository/reperes_repository.dart';

class PlacettesRepositoryImpl implements PlacettesRepository {
  final PlacettesDatabase database;
  final ArbresRepository arbresRepository;
  final BmsSup30Repository bmsRepository;
  final ReperesRepository reperesRepository;
  final CorCyclesPlacettesRepository corCyclePlacetteRepository;

  const PlacettesRepositoryImpl(
    this.database,
    this.arbresRepository,
    this.bmsRepository,
    this.reperesRepository,
    this.corCyclePlacetteRepository,
  );

  @override
  Future<Placette> getPlacette(int placetteId) async {
    final placetteEntity = await database.getPlacette(placetteId);
    return PlacetteMapper.transformFromDBToModel(placetteEntity);
  }

  @override
  Future<List<Placette>> getPlacettesForDispositif(int dispositifId) async {
    final placetteEntities =
        await database.getPlacettesByDispositifId(dispositifId);
    return placetteEntities.map(PlacetteMapper.transformFromDBToModel).toList();
  }

  @override
  Future<void> deletePlacetteAndSubObject(int placetteId) async {
    // delete all he arbres linked to the placette
    List<String> arbresIds =
        await arbresRepository.getArbreIdsForPlacette(placetteId);
    for (var arbreId in arbresIds) {
      await arbresRepository.deleteArbreAndArbreMesureFromIdArbre(arbreId);
    }

    // delete all he bms linked to the placette
    List<String> bmsIds =
        await bmsRepository.getBmSup30IdsForPlacette(placetteId);

    for (var bmId in bmsIds) {
      await bmsRepository.deleteBmSup30AndBmSup30MesureFromIdBmSup30(bmId);
    }

    // delete repere from id placette
    await reperesRepository.deleteRepereFromPlacetteId(placetteId);

    // delete all he corCyclePlacette linked to the placette
    List<String> corCyclePlacetteIds = await corCyclePlacetteRepository
        .getCorCyclePlacetteIdsForPlacette(placetteId);
    for (var corCyclePlacetteId in corCyclePlacetteIds) {
      await corCyclePlacetteRepository
          .deleteCorCyclePlacetteTransectAndRege(corCyclePlacetteId);
    }

    // Finally, delete the placette itself
    await database.deletePlacette(placetteId);
  }

  @override
  Future<Placette> updatePlacette(
    int placetteId,
    double pente,
    int exposition,
  ) async {
    final placetteEntity = await database.updatePlacette(
        PlacetteMapper.transformToNewEntityMap(placetteId, pente, exposition));
    return PlacetteMapper.transformFromDBToModel(placetteEntity);
  }
}
