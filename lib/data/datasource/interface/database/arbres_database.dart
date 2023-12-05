import 'package:dendro3/data/entity/arbres_entity.dart';

abstract class ArbresDatabase {
  // Future<ArbreListEntity> allArbres();
  Future<ArbreEntity> addArbre(final ArbreEntity arbreEntity);
  Future<ArbreEntity> updateArbre(final ArbreEntity arbreEntity);
  Future<void> deleteArbre(final int id);
}
