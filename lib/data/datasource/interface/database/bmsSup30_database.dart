import 'package:dendro3/data/entity/bmsSup30_entity.dart';

abstract class BmsSup30Database {
  // Future<BmSup30ListEntity> allBmsSup30();
  Future<BmSup30Entity> addBmSup30(final BmSup30Entity bmSup30Entity);
  Future<BmSup30Entity> updateBmSup30(final BmSup30Entity bmSup30Entity);
  Future<void> deleteBmSup30(final String id);
  Future<List<String>> getBmSup30IdsForPlacette(final int idPlacette);
  Future<void> actualizeBmIdBmSup30OrigAfterSync(
      List<Map<String, dynamic>> bmsList);
}
