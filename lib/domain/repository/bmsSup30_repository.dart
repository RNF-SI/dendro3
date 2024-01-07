import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';

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
    final int idBmSup30,
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

  Future<void> deleteBmSup30(final int idBmSup30);
}
