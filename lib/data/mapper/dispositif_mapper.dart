import 'package:dendro3/data/entity/dispositifs_entity.dart';
import 'package:dendro3/domain/model/dispositif.dart';
// import 'package:dendro3/domain/model/dispositif_id.dart';

class DispositifMapper {
  static Dispositif transformToModel(final DispositifEntity entity) {
    return Dispositif(
      id: entity['id'],
      name: entity['name'],
      idOrganisme: entity['idOrganisme'],
      alluvial: entity['alluvial'] == 1,
    );
  }

  static DispositifEntity transformToMap(final Dispositif model) {
    return {
      'id': model.id,
      'name': model.name,
      'idOrganisme': model.idOrganisme,
      'alluvial': model.alluvial ? 1 : 0,
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
