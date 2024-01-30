import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/repository/transects_repository.dart';
// import 'package:dendro3/domain/model/transectMesure_list.dart';
import 'package:dendro3/domain/usecase/create_transect_usecase.dart';

class CreateTransectUseCaseImpl implements CreateTransectUseCase {
  final TransectsRepository _transectRepository;

  const CreateTransectUseCaseImpl(this._transectRepository);

  @override
  Future<Transect> execute(
    final String idCyclePlacette,
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
    Transect transectObj = await _transectRepository.insertTransect(
        idCyclePlacette,
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
        observation);

    return transectObj;
  }
}
