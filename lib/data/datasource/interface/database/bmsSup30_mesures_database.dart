import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';

abstract class BmsSup30MesuresDatabase {
  Future<BmSup30MesureEntity> addBmSup30Mesure(
      final BmSup30MesureEntity BmSup30MesureEntity);
  // Future<BmSup30ListEntity> allBmsSup30Mesures();
  // Future<BmSup30Entity> insertBmSup30(
  //     final BmSup30Entity bmSup30Entity);
  Future<BmSup30MesureEntity> updateBmSup30Mesure(
      final BmSup30MesureEntity bmSup30MesureEntity);
  // Future<void> deleteBmSup30(final int id);
}
