import 'package:dendro3/core/helpers/sync_count.dart';
import 'package:dendro3/data/datasource/interface/api/cycles_api.dart';
import 'package:dendro3/data/mapper/arbreMesure_mapper.dart';
import 'package:dendro3/data/mapper/arbre_mapper.dart';
import 'package:dendro3/data/mapper/bmSup30Mesure_mapper.dart';
import 'package:dendro3/data/mapper/bmSup30_mapper.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_mapper.dart';
import 'package:dendro3/data/mapper/cycle_mapper.dart';
import 'package:dendro3/data/mapper/placette_mapper.dart';
import 'package:dendro3/data/mapper/regeneration_mapper.dart';
import 'package:dendro3/data/mapper/repere_mapper.dart';
import 'package:dendro3/data/mapper/transect_mapper.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';

class SyncResults {
  final List<Cycle> cycles;
  final List<Placette> placettes;
  final SyncCounts counts;

  SyncResults({
    required this.cycles,
    required this.placettes,
    required this.counts,
  });

  factory SyncResults.fromApi(
      Map<String, dynamic> jsonData, Map<String, dynamic> countsData) {
    var cyclesList = jsonData['cycles'] ?? [];
    var placettesList = jsonData['placettes'] ?? [];
    // var counts = countsData != null
    //     ? SyncCounts.fromJson(countsData)
    //     : SyncCounts.empty();
    var isCountsEmpty = countsData == null ||
        countsData.isEmpty ||
        countsData.keys
            .where((k) => countsData[k] != null && countsData[k] != {})
            .isEmpty;

    var counts = isCountsEmpty
        ? SyncCounts.empty()
        : SyncCounts.fromJson(countsData as Map<String, dynamic>);

    return SyncResults(
      cycles: cyclesList
          .map<Cycle>((item) => CycleMapper.transformFromApiToModel(item))
          .toList(),
      placettes: placettesList
          .map<Placette>((item) => PlacetteMapper.fromApi(item))
          .toList(),
      counts: counts,
    );
  }
}
