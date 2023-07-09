import 'package:dendro3/data/entity/arbresMesures_entity.dart';
import 'package:dendro3/data/entity/placettes_entity.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/placette.dart';

class ArbreMesureMapper {
  // static ArbreMesure transformToModel(final ArbreMesureEntity entity) {
  //   return ArbreMesure(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static ArbreMesure transformFromApiToModel(final ArbreMesureEntity entity) {
    return ArbreMesure(
        idArbreMesure: entity['id_arbre_mesure'],
        idArbre: entity['id_arbre'],
        idCycle: entity['id_cycle'],
        diametre1: entity['diametre1'],
        diametre2: entity['diametre2'],
        type: entity['type'],
        hauteurTotale: entity['hauteur_totale'],
        hauteurBranche: entity['hauteur_branche'],
        stadeDurete: entity['stade_durete'],
        stadeEcorce: entity['stade_ecorce'],
        liane: entity['liane'],
        diametreLiane: entity['diametre_liane'],
        coupe: entity['coupe'],
        limite: entity['limite'] == true ? true : false,
        idNomenclatureCodeSanitaire: entity['id_nomenclature_code_sanitaire'],
        codeEcolo: entity['code_ecolo'],
        refCodeEcolo: entity['ref_code_ecolo'],
        ratioHauteur: entity['ratio_hauteur'] == true ? true : false,
        observation: entity['observation']);
  }

  static ArbreMesureEntity transformToMap(final ArbreMesure model) {
    return {
      'id_arbre_mesure': model.idArbreMesure,
      'id_arbre': model.idArbre,
      'id_cycle': model.idCycle,
      'diametre1': model.diametre1,
      'diametre2': model.diametre2,
      'type': model.type,
      'hauteur_totale': model.hauteurTotale,
      'hauteur_branche': model.hauteurBranche,
      'stade_durete': model.stadeDurete,
      'stade_ecorce': model.stadeEcorce,
      'liane': model.liane,
      'diametre_liane': model.diametreLiane,
      'coupe': model.coupe,
      'limite': model.limite == true ? true : false,
      'id_nomenclature_code_sanitaire': model.idNomenclatureCodeSanitaire,
      'code_ecolo': model.codeEcolo,
      'ref_code_ecolo': model.refCodeEcolo,
      'ratio_hauteur': model.ratioHauteur,
      'observation': model.observation
    };
  }

  static ArbreMesureEntity transformToNewEntityMap(
    final int? idArbre,
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  ) {
    return {
      'id_arbre': idArbre,
      'id_cycle': idCycle,
      'diametre1': diametre1,
      'diametre2': diametre2,
      'type': type,
      'hauteur_totale': hauteurTotale,
      'hauteur_branche': hauteurBranche,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'liane': liane,
      'diametre_liane': diametreLiane,
      'coupe': coupe,
      'limite': limite,
      'id_nomenclature_code_sanitaire': idNomenclatureCodeSanitaire,
      'code_ecolo': codeEcolo,
      'ref_code_ecolo': refCodeEcolo,
      'ratio_hauteur': ratioHauteur,
      'observation': observationMesure,
    };
  }

  // Function concentratingh only on arbre properties (and not on arbreMesures)
  static ArbreMesure transformToModel(final ArbreMesureEntity entity) {
    return ArbreMesure(
        idArbreMesure: entity['id_arbre_mesure'],
        idArbre: entity['id_arbre'],
        idCycle: entity['id_cycle'],
        diametre1: entity['diametre1'],
        diametre2: entity['diametre2'],
        type: entity['type'],
        hauteurTotale: entity['hauteur_totale'],
        hauteurBranche: entity['hauteur_branche'],
        stadeDurete: entity['stade_durete'],
        stadeEcorce: entity['stade_ecorce'],
        liane: entity['liane'],
        diametreLiane: entity['diametre_liane'],
        coupe: entity['coupe'],
        limite: entity['limite'] == true ? true : false,
        idNomenclatureCodeSanitaire: entity['id_nomenclature_code_sanitaire'],
        codeEcolo: entity['code_ecolo'],
        refCodeEcolo: entity['ref_code_ecolo'],
        ratioHauteur: entity['ratio_hauteur'] == true ? true : false,
        observation: entity['observation']);
  }
}
