import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/repository/reperes_repository.dart';
import 'package:dendro3/domain/usecase/update_repere_usecase.dart';

class UpdateRepereUseCaseImpl implements UpdateRepereUseCase {
  final ReperesRepository _repereRepository;

  UpdateRepereUseCaseImpl(this._repereRepository);

  @override
  Future<Repere> execute(
    final String idRepere,
    final int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  ) async {
    Repere repereObj = await _repereRepository.updateRepere(
      idRepere,
      idPlacette,
      azimut,
      distance,
      diametre,
      repere,
      observation,
    );

    return repereObj;
  }
}
