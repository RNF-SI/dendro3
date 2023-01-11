import 'package:dendro3/domain/model/placette.dart';

abstract class PlacettesRepository {
  Future<Placette> getPlacette(int placetteId);
}
