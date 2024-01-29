import 'package:dendro3/data/entity/regenerations_entity.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/repository/regenerations_repository.dart';
// import 'package:dendro3/domain/model/regenerationMesure_list.dart';
import 'package:dendro3/domain/usecase/create_regeneration_usecase.dart';

class CreateRegenerationUseCaseImpl implements CreateRegenerationUseCase {
  final RegenerationsRepository _regenerationRepository;

  const CreateRegenerationUseCaseImpl(this._regenerationRepository);

  @override
  Future<Regeneration> execute(
      final String idCyclePlacette,
      final int sousPlacette,
      final String codeEssence,
      final double recouvrement,
      final int classe1,
      final int classe2,
      final int classe3,
      final bool taillis,
      final bool abroutissement,
      int? idNomenclatureAbroutissement,
      String? observation) async {
    Regeneration regenerationObj =
        await _regenerationRepository.insertRegeneration(
      idCyclePlacette,
      sousPlacette,
      codeEssence,
      recouvrement,
      classe1,
      classe2,
      classe3,
      taillis,
      abroutissement,
      idNomenclatureAbroutissement,
      observation,
    );

    return regenerationObj;
    // return aa;
  }
}
