import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/repository/transects_repository.dart';
import 'package:dendro3/domain/usecase/update_transect_usecase.dart';

class UpdateTransectUseCaseImpl implements UpdateTransectUseCase {
  final TransectsRepository _transectRepository;

  UpdateTransectUseCaseImpl(this._transectRepository);

  @override
  Future<Transect> execute(
    final int idTransect,
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
    Transect transectUpdated = await _transectRepository.updateTransect(
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
    );

    return transectUpdated;
  }
}
