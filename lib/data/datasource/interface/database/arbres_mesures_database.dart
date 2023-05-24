import 'package:dendro3/data/entity/arbresMesures_entity.dart';

abstract class ArbresMesuresDatabase {
  Future<ArbreMesureEntity> addArbreMesure(
      final ArbreMesureEntity arbreMesureEntity);

  // Future<ArbreMesureListEntity> allArbresMesures();
  // Future<ArbreMesureEntity> insertArbreMesure(
  //     final ArbreMesureEntity arbreMesureEntity);
  // Future<void> updateArbreMesure(final ArbreMesureEntity arbreMesureEntity);
  // Future<void> deleteArbreMesure(final int id);
}
