import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/data/mapper/cycle_list_mapper.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
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

  static Dispositif transformFromApiToModel(final Map<String, dynamic> entity) {
    try {
      return Dispositif(
        id: entity['id_dispositif'] ?? logAndReturnNull<int>('id_dispositif'),
        name: entity['name'] ?? logAndReturnNull<String>('name'),
        idOrganisme:
            entity['id_organisme'] ?? logAndReturnNull<int>('id_organisme'),
        alluvial: entity['alluvial'] ?? logAndReturnNull<bool>('alluvial'),
        placettes: entity.containsKey('placettes')
            ? PlacetteListMapper.transformFromApiToModel(entity['placettes'])
            : null,
        cycles: entity.containsKey('cycles')
            ? CycleListMapper.transformFromApiToModel(entity['cycles'])
            : null,
      );
    } catch (e) {
      print("Error in Dispositif transformFromApiToModel: $e");

      throw e;
    }
  }

  static Dispositif transformFromDBToModel(final DispositifEntity entity) {
    try {
      return Dispositif(
          id: entity['id_dispositif'],
          name: entity['name'],
          idOrganisme: entity['id_organisme'],
          alluvial: entity['alluvial'] == 1 ? true : false,
          placettes: entity.containsKey('placettes')
              ? PlacetteListMapper.transformFromDBToModel(entity['placettes'])
              : null,
          cycles: entity.containsKey('cycles')
              ? CycleListMapper.transformFromDBToModel(entity['cycles'])
              : null);
    } catch (e) {
      print("Error in Dispositif transformFromDBToModel: $e");

      throw e;
    }
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
