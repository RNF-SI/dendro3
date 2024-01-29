import 'dart:io';

import 'package:dendro3/data/datasource/interface/api/cycles_api.dart';
import 'package:dendro3/data/datasource/interface/database/cycles_database.dart';
import 'package:dendro3/data/datasource/interface/database/dispositifs_database.dart';
import 'package:dendro3/data/datasource/interface/api/dispositifs_api.dart';
import 'package:dendro3/data/mapper/cycle_list_mapper.dart';
import 'package:dendro3/data/mapper/dispositif_list_mapper.dart';
import 'package:dendro3/data/mapper/dispositif_mapper.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/repository/cycles_repository.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';

class CyclesRepositoryImpl implements CyclesRepository {
  final CyclesDatabase database;
  final CyclesApi api;

  const CyclesRepositoryImpl(this.database, this.api);

  @override
  Future<void> updateDispositifCycles(final int id) async {
    final cycleListEntity = await api.getDispositifCycles(id);
    final localCycleListEntity = await database.getDispositifCycles(id);
    // Add/update local cycles
    cycleListEntity.forEach((cycle) async {
      if (localCycleListEntity
          .map((localCycle) => localCycle['id_cycle'])
          .toList()
          .contains(cycle['id_cycle'])) {
        await database.updateCycle(cycle);
      } else {
        await database.addCycle(cycle);
      }
    });
  }

  @override
  Future<void> deleteCycleFromDispositifId(
    final int dispositifId,
  ) async {
    await database.deleteCycleFromDispositifId(dispositifId);
  }
}
