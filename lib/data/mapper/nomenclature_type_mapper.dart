import 'package:dendro3/data/entity/nomencluresTypes_entity.dart';
import 'package:dendro3/domain/model/nomenclatureType.dart';
// import 'package:dendro3/domain/model/nomenclaturetype_id.dart';

class NomenclatureTypeMapper {
  static NomenclatureType transformFromApiToModel(
      final NomenclatureTypeEntity entity) {
    return NomenclatureType(
      idType: entity['id_type'],
      mnemonique: entity['mnemonique'],
      labelDefault: entity['label_default'],
      definitionDefault: entity['definition_default'],
      labelFr: entity['label_fr'],
      definitionFr: entity['definition_fr'],
      labelEn: entity['label_en'],
      definitionEn: entity['definition_en'],
      labelEs: entity['label_es'],
      definitionEs: entity['definition_es'],
      labelDe: entity['label_de'],
      definitionDe: entity['definition_de'],
      labelIt: entity['label_it'],
      definitionIt: entity['definition_it'],
      source: entity['source'],
      statut: entity['statut'],
    );
  }

  static NomenclatureType transformToModel(
      final NomenclatureTypeEntity entity) {
    return NomenclatureType(
      idType: entity['id_type'],
      mnemonique: entity['mnemonique'],
      labelDefault: entity['label_default'],
      definitionDefault: entity['definition_default'],
      labelFr: entity['label_fr'],
      definitionFr: entity['definition_fr'],
      labelEn: entity['label_en'],
      definitionEn: entity['definition_en'],
      labelEs: entity['label_es'],
      definitionEs: entity['definition_es'],
      labelDe: entity['label_de'],
      definitionDe: entity['definition_de'],
      labelIt: entity['label_it'],
      definitionIt: entity['definition_it'],
      source: entity['source'],
      statut: entity['statut'],
    );
  }
}
