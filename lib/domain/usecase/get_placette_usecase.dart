import 'package:dendro3/domain/model/placette.dart';

abstract class GetPlacetteUseCase {
  Future<Placette> execute(
    final int placetteId,
  );
}
