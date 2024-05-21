import 'package:dendro3/domain/model/bmSup30.dart';

abstract class BmsSup30Repository {
  Future<BmSup30> insertBmSup30(
    final int idPlacette,
    final int? idArbre,
    final String codeEssence,
    final double azimut,
    final double distance,
    final double? orientation,
    final double? azimutSouche,
    final double? distanceSouche,
    final String? observation,
  );

  Future<BmSup30> updateBmSup30(
    final String idBmSup30,
    final int idBmSup30Orig,
    final int idPlacette,
    final int? idArbre,
    final String codeEssence,
    final double azimut,
    final double distance,
    final double? orientation,
    final double? azimutSouche,
    final double? distanceSouche,
    final String? observation,
  );

  Future<void> deleteBmSup30(final String idBmSup30);

  Future<List<String>> getBmSup30IdsForPlacette(final int idPlacette);

  Future<void> deleteBmSup30AndBmSup30MesureFromIdBmSup30(
      final String idBmSup30);

  Future<void> actualizeBmIdBmSup30OrigAfterSync(
      final List<Map<String, dynamic>> bms);

  Future<void> setBmSup30AsUpdated(final String idBmSup30);
}
