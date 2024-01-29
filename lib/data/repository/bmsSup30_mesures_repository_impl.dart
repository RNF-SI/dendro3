import 'dart:io';

import 'package:dendro3/data/datasource/interface/database/bmsSup30_mesures_database.dart';
import 'package:dendro3/data/mapper/bmSup30Mesure_mapper.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
// import 'package:dendro3/domain/model/bmSup30_id.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BmsSup30MesuresRepositoryImpl implements BmsSup30MesuresRepository {
  final BmsSup30MesuresDatabase database;

  const BmsSup30MesuresRepositoryImpl(this.database);

  @override
  Future<BmSup30Mesure> insertBmSup30Mesure(
      final String idBmSup30,
      final int idCycle,
      double? diametreIni,
      double? diametreMed,
      double? diametreFin,
      double? diametre130,
      final double longueur,
      bool? ratioHauteur,
      final double contact,
      final bool chablis,
      final int stadeDurete,
      final int stadeEcorce,
      String? observation) async {
    final bmsup30Entity = await database
        .addBmSup30Mesure(BmSup30MesureMapper.transformToNewEntityMap(
      idBmSup30,
      idCycle,
      diametreIni,
      diametreMed,
      diametreFin,
      diametre130,
      longueur,
      ratioHauteur,
      contact,
      chablis,
      stadeDurete,
      stadeEcorce,
      observation,
    ));

    return BmSup30MesureMapper.transformToModel(bmsup30Entity);
  }

  @override
  Future<BmSup30Mesure> updateBmSup30Mesure(
      final String idBmSup30Mesure,
      final String idBmSup30,
      final int idCycle,
      double? diametreIni,
      double? diametreMed,
      double? diametreFin,
      double? diametre130,
      final double longueur,
      bool? ratioHauteur,
      final double contact,
      final bool chablis,
      final int stadeDurete,
      final int stadeEcorce,
      String? observation) async {
    final bmsup30Entity = await database.updateBmSup30Mesure(
        BmSup30MesureMapper.transformToEntityMap(
            idBmSup30Mesure,
            idBmSup30,
            idCycle,
            diametreIni,
            diametreMed,
            diametreFin,
            diametre130,
            longueur,
            ratioHauteur,
            contact,
            chablis,
            stadeDurete,
            stadeEcorce,
            observation));

    return BmSup30MesureMapper.transformToModel(bmsup30Entity);
  }

  @override
  Future<void> deleteBmSup30FromIdBmSup30(String idBmSup30Mesure) async {
    await database.deleteBmSup30MesureFromIdBmSup30(idBmSup30Mesure);
  }

  @override
  Future<void> deleteBmsSup30Mesure(String idBmSup30Mesure) async {
    await database.deleteBmSup30Mesure(idBmSup30Mesure);
  }
}
