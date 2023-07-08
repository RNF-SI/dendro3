import 'package:dendro3/domain/model/regeneration.dart';

abstract class RegenerationsRepository {
  Future<Regeneration> insertRegeneration(
    final int idCyclePlacette,
    final int sousPlacette,
    final String codeEssence,
    final double recouvrement,
    final int classe1,
    final int classe2,
    final int classe3,
    final bool taillis,
    final bool abroutissement,
    int? idNomenclatureAbroutissement,
    String? observation,
  );
}
