import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/bmsSup30_database.dart';
import 'package:dendro3/data/mapper/bmSup30_mapper.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
// import 'package:dendro3/domain/model/bmSup30_id.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';

class BmsSup30RepositoryImpl implements BmsSup30Repository {
  final BmsSup30Database database;
  final BmsSup30MesuresRepository bmsSup30MesuresRepository;

  const BmsSup30RepositoryImpl(
    this.database,
    this.bmsSup30MesuresRepository,
  );

  @override
  Future<BmSup30> insertBmSup30(
      int idPlacette,
      int? idArbre,
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

  @override
  Future<BmSup30> updateBmSup30(
      int idBmSup30,
      int idBmSup30Orig,
      int idPlacette,
      int? idArbre,
      String codeEssence,
      double azimut,
      double distance,
      double? orientation,
      double? azimutSouche,
      double? distanceSouche,
      String? observation) async {
    final bmSup30Entity = await database.updateBmSup30(
        BmSup30Mapper.transformToEntityMap(
            idBmSup30,
            idBmSup30Orig,
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

  @override
  Future<void> deleteBmSup30(int idBmSup30) {
    return database.deleteBmSup30(idBmSup30);
  }

  @override
  Future<List<int>> getBmSup30IdsForPlacette(int idPlacette) async {
    return await database.getBmSup30IdsForPlacette(idPlacette);
  }

  @override
  Future<void> deleteBmSup30AndBmSup30MesureFromIdBmSup30(int idBmSup30) async {
    await bmsSup30MesuresRepository.deleteBmSup30FromIdBmSup30(idBmSup30);
    await database.deleteBmSup30(idBmSup30);
  }
}
