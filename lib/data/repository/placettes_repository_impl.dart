import 'package:dendro3/data/datasource/interface/database/placettes_database.dart';
import 'package:dendro3/data/mapper/placette_mapper.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';

class PlacettesRepositoryImpl implements PlacettesRepository {
  final PlacettesDatabase database;

  const PlacettesRepositoryImpl(this.database);

  @override
  Future<Placette> getPlacette(int placetteId) async {
    final placetteEntity = await database.getPlacette(placetteId);
    return PlacetteMapper.transformFromDBToModel(placetteEntity);
  }
}
