import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';
import 'package:dendro3/domain/usecase/update_placette_usecase.dart';

class UpdatePlacetteUseCaseImpl implements UpdatePlacetteUseCase {
  final PlacettesRepository _placetteRepository;

  const UpdatePlacetteUseCaseImpl(this._placetteRepository);

  @override
  Future<Placette> execute(
    int idPlacette,
    double pente,
    int exposition,
  ) async {
    Placette placetteUpdated = await _placetteRepository.updatePlacette(
      idPlacette,
      pente,
      exposition,
    );

    return placetteUpdated;
  }
}
