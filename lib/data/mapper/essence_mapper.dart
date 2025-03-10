import 'package:dendro3/data/entity/essences_entity.dart';
import 'package:dendro3/domain/model/essence.dart';
// import 'package:dendro3/domain/model/essence_id.dart';

class EssenceMapper {
  static Essence transformFromApiToModel(final EssenceEntity entity) {
    return Essence(
        codeEssence: entity['code_essence'],
        cdNom: entity['cd_nom'],
        nom: entity['nom'],
        nomLatin: entity['nom_latin'],
        essReg: entity['ess_reg'],
        couleur: entity['couleur']);
  }

  static Essence transformToModel(final EssenceEntity entity) {
    return Essence(
        codeEssence: entity['code_essence'],
        cdNom: entity['cd_nom'],
        nom: entity['nom'],
        nomLatin: entity['nom_latin'],
        essReg: entity['ess_reg'],
        couleur: entity['couleur']);
  }
}
