import 'package:dendro3/data/entity/bmsSup30_entity.dart';

abstract class BmsSup30Database {
  // Future<BmSup30ListEntity> allBmsSup30();
  Future<BmSup30Entity> addBmSup30(final BmSup30Entity bmSup30Entity);
  // Future<void> updateBmSup30(final BmSup30Entity bmSup30Entity);
  // Future<void> deleteBmSup30(final int id);
}
