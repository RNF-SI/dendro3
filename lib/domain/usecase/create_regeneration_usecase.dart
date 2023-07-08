import 'package:dendro3/domain/model/repere.dart';

abstract class CreateRegenerationUseCase {
  Future<Repere> execute(
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
      String? observation);
}
