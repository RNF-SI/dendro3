import 'package:dendro3/domain/model/regeneration.dart';

abstract class UpdateRegenerationUseCase {
  Future<Regeneration> execute(
    int idRegeneration,
    int idCyclePlacette,
    int sousPlacette,
    String codeEssence,
    double recouvrement,
    int classe1,
    int classe2,
    int classe3,
    bool taillis,
    bool abroutissement,
    int? idNomenclatureAbroutissement,
    String? observation,
  );
}
