import 'package:dendro3/data/entity/reperes_entity.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/repository/reperes_repository.dart';
// import 'package:dendro3/domain/model/repereMesure_list.dart';
import 'package:dendro3/domain/usecase/create_repere_usecase.dart';

class CreateRepereUseCaseImpl implements CreateRepereUseCase {
  final ReperesRepository _repereRepository;

  const CreateRepereUseCaseImpl(this._repereRepository);

  @override
  Future<Repere> execute(
      // int idRepereOrig,
      final int idPlacette,
      double? azimut,
      double? distance,
      double? diametre,
      String? repere,
      String? observation) async {
    Repere repereObj = await _repereRepository.insertRepere(
        idPlacette, azimut, distance, diametre, repere, observation);

    return repereObj;
    // return aa;
  }
}
