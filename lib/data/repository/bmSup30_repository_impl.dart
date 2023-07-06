import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/bmsSup30_database.dart';
import 'package:dendro3/data/mapper/bmSup30_mapper.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
// import 'package:dendro3/domain/model/bmSup30_id.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';

class BmsSup30RepositoryImpl implements BmsSup30Repository {
  final BmsSup30Database database;

  const BmsSup30RepositoryImpl(this.database);

  @override
  Future<BmSup30> insertBmSup30(
      int idPlacette,
      int idArbre,
      String codeEssence,
      double azimut,
      double distance,
      double? orientation,
      double? azimutSouche,
      double? distanceSouche,
      String? observation) async {
    final bmSup30Entity =
        await database.addBmSup30(BmSup30Mapper.transformToNewEntityMap(
            // idBmSup30Orig,
            idPlacette,
            idArbre,
            codeEssence,
            azimut,
            distance,
            orientation,
            azimutSouche,
            distanceSouche,
            observation));

    return BmSup30Mapper.transformToModel(bmSup30Entity);
  }
}
