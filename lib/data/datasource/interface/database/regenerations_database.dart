import 'package:dendro3/data/entity/regenerations_entity.dart';

abstract class RegenerationsDatabase {
  // Future<RegenerationListEntity> allRegenerations();
  Future<RegenerationEntity> addRegeneration(
      final RegenerationEntity regenerationEntity);
  Future<RegenerationEntity> updateRegeneration(
      final RegenerationEntity regenerationEntity);

  // Future<void> updateRegeneration(final RegenerationEntity regenerationEntity);
  Future<void> deleteRegeneration(final String id);

  Future<void> deleteRegenerationsForCorCyclePlacette(String idCyclePlacette);
}
