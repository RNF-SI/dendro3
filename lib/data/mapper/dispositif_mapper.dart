import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/mapper/cycle_list_mapper.dart';
import 'package:dendro3/data/mapper/placette_list_mapper.dart';
import 'package:dendro3/data/mapper/placette_mapper.dart';
import 'package:dendro3/domain/model/dispositif.dart';
// import 'package:dendro3/domain/model/dispositif_id.dart';

class DispositifMapper {
  static Dispositif transformToModel(final DispositifEntity entity) {
    return Dispositif(
      id: entity['id_dispositif'],
      name: entity['name'],
      idOrganisme: entity['id_organisme'],
      alluvial: entity['alluvial'] == 1,
    );
  }

  static Dispositif transformFromApiToModel(final DispositifEntity entity) {
    return Dispositif(
        id: entity['id_dispositif'],
        name: entity['name'],
        idOrganisme: entity['id_organisme'],
        alluvial: entity['alluvial'],
        placettes: entity.containsKey('placettes')
            ? PlacetteListMapper.transformFromApiToModel(entity['placettes'])
            : null,
        cycles: entity.containsKey('cycles')
            ? CycleListMapper.transformFromApiToModel(entity['cycles'])
            : null);
  }

  static DispositifEntity transformToMap(final Dispositif model) {
    return {
      'id_dispositif': model.id,
      'name': model.name,
      'id_organisme': model.idOrganisme,
      'alluvial': model.alluvial ? 1 : 0,
      'placettes': model.placettes != null
          ? PlacetteListMapper.transformToMap(model.placettes!)
          : null,
      'cycles': model.cycles != null
          ? CycleListMapper.transformToMap(model.cycles!)
          : null
    };
  }

  static DispositifEntity transformToNewEntityMap(
    final String name,
    final int idOrganisme,
    final bool alluvial,
  ) {
    return {
      'id': null,
      'name': name,
      'idOrganisme': idOrganisme,
      'alluvial': alluvial ? 1 : 0,
    };
  }
}
