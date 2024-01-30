import 'package:dendro3/data/entity/nomenclatures_entity.dart';
import 'package:dendro3/domain/model/nomenclature.dart';
// import 'package:dendro3/domain/model/nomenclature_id.dart';

class NomenclatureMapper {
  static Nomenclature transformFromApiToModel(final NomenclatureEntity entity) {
    return Nomenclature(
      idNomenclature: entity['id_nomenclature'],
      idType: entity['id_type'],
      cdNomenclature: entity['cd_nomenclature'],
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
      idBroader: entity['id_broader'],
      hierarchy: entity['hierarchy'],
      active: entity['active'],
    );
  }

  static Nomenclature transformToModel(final NomenclatureEntity entity) {
    return Nomenclature(
      idNomenclature: entity['id_nomenclature'],
      idType: entity['id_type'],
      cdNomenclature: entity['cd_nomenclature'],
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
      idBroader: entity['id_broader'],
      hierarchy: entity['hierarchy'],
      active: entity['active'] == true ? true : false,
    );
  }
}
