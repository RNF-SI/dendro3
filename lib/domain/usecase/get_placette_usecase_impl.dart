import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase.dart';

class GetPlacetteUseCaseImpl implements GetPlacetteUseCase {
  final PlacettesRepository _repository;

  const GetPlacetteUseCaseImpl(this._repository);

  @override
  Future<Placette> execute(
    final int placetteId,
  ) =>
      _repository.getPlacette(placetteId);
}
