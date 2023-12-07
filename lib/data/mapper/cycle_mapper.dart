import 'package:dendro3/data/entity/cycles_entity.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_list_mapper.dart';
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

  static Cycle transformFromApiToModel(final CycleEntity entity) {
    return Cycle(
        idCycle: entity['id_cycle'],
        idDispositif: entity['id_dispositif'],
        numCycle: entity['num_cycle'],
        coeff: entity['coeff'],
        dateDebut: entity['date_debut'] != null
            ? DateTime.parse(entity['date_debut'])
            : null,
        dateFin: entity['date_fin'] != null
            ? DateTime.parse(entity['date_fin'])
            : null,
        diamLim: entity['diam_lim'],
        monitor: entity['monitor'],
        corCyclesPlacettes: entity.containsKey('corCyclesPlacettes')
            ? CorCyclePlacetteListMapper.transformFromApiToModel(
                entity['corCyclesPlacettes'])
            : null);
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
