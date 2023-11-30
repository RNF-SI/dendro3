import 'package:dendro3/data/entity/reperes_entity.dart';

abstract class ReperesDatabase {
  // Future<RepereListEntity> allReperes();
  Future<RepereEntity> addRepere(final RepereEntity repereEntity);
  Future<RepereEntity> updateRepere(final RepereEntity repereEntity);
  // Future<void> deleteRepere(final int id);
}
