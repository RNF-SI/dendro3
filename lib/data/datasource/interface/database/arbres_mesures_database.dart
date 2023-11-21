import 'package:dendro3/data/entity/arbresMesures_entity.dart';

abstract class ArbresMesuresDatabase {
  Future<ArbreMesureEntity> addArbreMesure(
      final ArbreMesureEntity arbreMesureEntity);

  Future<ArbreMesureEntity> updateArbreMesure(
      final ArbreMesureEntity arbreMesureEntity);

  Future<ArbreMesureEntity> getPreviousCycleMeasure(
    final int idArbre,
    final int? idCycle,
    int? numCycle,
  );

  Future<void> updateLastArbreMesureCoupe(
    final int idArbre,
    final int? idCycle,
    final String? coupe,
  );

  // Future<ArbreMesureListEntity> allArbresMesures();
  // Future<ArbreMesureEntity> insertArbreMesure(
  //     final ArbreMesureEntity arbreMesureEntity);
  // Future<void> updateArbreMesure(final ArbreMesureEntity arbreMesureEntity);
  // Future<void> deleteArbreMesure(final int id);
}
