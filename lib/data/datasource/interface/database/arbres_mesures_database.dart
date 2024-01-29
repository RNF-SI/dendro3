import 'package:dendro3/data/entity/arbresMesures_entity.dart';

abstract class ArbresMesuresDatabase {
  Future<ArbreMesureEntity> addArbreMesure(
      final ArbreMesureEntity arbreMesureEntity);

  Future<ArbreMesureEntity> updateArbreMesure(
      final ArbreMesureEntity arbreMesureEntity);

  Future<ArbreMesureEntity> getPreviousCycleMeasure(
    final String idArbre,
    final int? idCycle,
    int? numCycle,
  );

  Future<ArbreMesureEntity> updateLastArbreMesureCoupe(
    final String idArbreMesure,
    final String? coupe,
  );

  Future<void> deleteArbreMesureFromIdArbre(final String idArbre);

  Future<void> deleteArbreMesure(final String idArbreMesure);

  // Future<ArbreMesureListEntity> allArbresMesures();
  // Future<ArbreMesureEntity> insertArbreMesure(
  //     final ArbreMesureEntity arbreMesureEntity);
  // Future<void> updateArbreMesure(final ArbreMesureEntity arbreMesureEntity);
  // Future<void> deleteArbreMesure(final int id);
}
