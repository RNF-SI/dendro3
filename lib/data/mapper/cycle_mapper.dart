import 'package:dendro3/data/entity/cycles_entity.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_list_mapper.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:intl/intl.dart';

class CycleMapper {
  // static Cycle transformToModel(final CycleEntity entity) {
  //   return Cycle(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static Cycle transformFromApiToModel(final Map<String, dynamic> entity) {
    try {
      return Cycle(
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        idDispositif:
            entity['id_dispositif'] ?? logAndReturnNull<int>('id_dispositif'),
        numCycle: entity['num_cycle'] ?? logAndReturnNull<int>('num_cycle'),
        coeff: entity['coeff'] as int?,
        dateDebut: entity['date_debut'] != null
            ? DateTime.parse(entity['date_debut'])
            : null,
        dateFin: entity['date_fin'] != null
            ? DateTime.parse(entity['date_fin'])
            : null,
        diamLim: entity['diam_lim'] as double?,
        monitor: entity['monitor'] as String?,
        corCyclesPlacettes: entity.containsKey('corCyclesPlacettes')
            ? CorCyclePlacetteListMapper.transformFromApiToModel(
                entity['corCyclesPlacettes'])
            : null,
      );
    } catch (e) {
      print("Error in Cycle transformFromApiToModel: $e");

      rethrow;
    }
  }

  static Cycle transformFromDBToModel(final Map<String, dynamic> entity) {
    try {
      return Cycle(
        idCycle: entity['id_cycle'] ?? logAndReturnNull<int>('id_cycle'),
        idDispositif:
            entity['id_dispositif'] ?? logAndReturnNull<int>('id_dispositif'),
        numCycle: entity['num_cycle'] ?? logAndReturnNull<int>('num_cycle'),
        coeff: entity['coeff'] as int?,
        dateDebut: entity['date_debut'] != null
            ? DateTime.parse(entity['date_debut'])
            : null,
        dateFin: entity['date_fin'] != null
            ? DateTime.parse(entity['date_fin'])
            : null,
        diamLim: entity['diam_lim'] as double?,
        monitor: entity['monitor'] as String?,
        corCyclesPlacettes: entity.containsKey('corCyclesPlacettes')
            ? CorCyclePlacetteListMapper.transformFromDBToModel(
                entity['corCyclesPlacettes'])
            : null,
      );
    } catch (e) {
      print("Error in Cycle transformFromDBToModel: $e");

      rethrow;
    }
  }

  static CycleEntity transformToMap(final Cycle model) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return {
      'id_cycle': model.idCycle,
      'id_dispositif': model.idDispositif,
      'num_cycle': model.numCycle,
      'coeff': model.coeff,
      'date_debut':
          model.dateDebut == null ? null : formatter.format(model.dateDebut!),
      'date_fin':
          model.dateFin == null ? null : formatter.format(model.dateFin!),
      'diam_lim': model.diamLim,
      'monitor': model.monitor,
      'corCyclesPlacettes': model.corCyclesPlacettes != null
          ? CorCyclePlacetteListMapper.transformToMap(model.corCyclesPlacettes!)
          : null
    };
  }

  // static CycleEntity transformToNewEntityMap(
  //   final String name,
  //   final int idOrganisme,
  //   final bool alluvial,
  // ) {
  //   return {
  //     'id': null,
  //     'name': name,
  //     'idOrganisme': idOrganisme,
  //     'alluvial': alluvial ? 1 : 0,
  //   };
  // }
}
