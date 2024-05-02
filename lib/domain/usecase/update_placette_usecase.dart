import 'package:dendro3/domain/model/placette.dart';

abstract class UpdatePlacetteUseCase {
  Future<Placette> execute(
    final int idPlacette,
    final double pente,
    final int exposition,
  );
}
