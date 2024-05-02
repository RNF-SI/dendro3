import 'package:dendro3/data/entity/arbres_entity.dart';

abstract class ArbresDatabase {
  // Future<ArbreListEntity> allArbres();
  Future<ArbreEntity> addArbre(final ArbreEntity arbreEntity);
  Future<ArbreEntity> updateArbre(final ArbreEntity arbreEntity);
  Future<void> deleteArbre(final String id);
  Future<List<String>> getArbreIdsForPlacette(final int idPlacette);
  Future<void> actualizeArbreIdArbreOrigAfterSync(
      final List<Map<String, dynamic>> arbresList);
}
