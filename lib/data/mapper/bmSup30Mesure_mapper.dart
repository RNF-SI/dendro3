import 'package:dendro3/data/entity/bmsSup30Mesures_entity.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';

class BmSup30MesureMapper {
  // static BmSup30Mesure transformToModel(final BmSup30MesureEntity entity) {
  //   return BmSup30Mesure(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static BmSup30Mesure transformFromApiToModel(
      final BmSup30MesureEntity entity) {
    return BmSup30Mesure(
      idBmSup30Mesure: entity['id_bm_sup_30_mesure'],
      idBmSup30: entity['id_bm_sup_30'],
      idCycle: entity['id_cycle'],
      diametreIni: entity['diametre_ini'],
      diametreMed: entity['diametre_med'],
      diametreFin: entity['diametre_fin'],
      diametre130: entity['diametre_130'],
      longueur: entity['longueur'],
      ratioHauteur: entity['ratio_hauteur'] == true ? true : false,
      contact: entity['contact'],
      chablis: entity['chablis'] == true ? true : false,
      stadeDurete: entity['stade_durete'],
      stadeEcorce: entity['stade_ecorce'],
      observation: entity['observation'],
    );
  }

  // Function concentratingh only on arbre properties (and not on arbreMesures)
  static BmSup30Mesure transformToModel(final BmSup30MesureEntity entity) {
    return BmSup30Mesure(
        idBmSup30Mesure: entity['id_bm_sup_30_mesure'],
        idBmSup30: entity['id_bm_sup_30'],
        idCycle: entity['id_cycle'],
        diametreIni: entity['diametre_ini'],
        diametreMed: entity['diametre_med'],
        diametreFin: entity['diametre_fin'],
        diametre130: entity['diametre_130'],
        longueur: entity['longueur'],
        ratioHauteur: entity['ratio_hauteur'],
        contact: entity['contact'],
        chablis: entity['chablis'],
        stadeDurete: entity['stade_durete'],
        stadeEcorce: entity['stade_ecorce'],
        observation: entity['observation']);
  }

  static BmSup30MesureEntity transformToMap(final BmSup30Mesure model) {
    return {
      'id_bm_sup_30_mesure': model.idBmSup30Mesure,
      'id_bm_sup_30': model.idBmSup30,
      'id_cycle': model.idCycle,
      'diametre_ini': model.diametreIni,
      'diametre_med': model.diametreMed,
      'diametre_fin': model.diametreFin,
      'diametre_130': model.diametre130,
      'longueur': model.longueur,
      'ratio_hauteur': model.ratioHauteur,
      'contact': model.contact,
      'chablis': model.chablis,
      'stade_durete': model.stadeDurete,
      'stade_ecorce': model.stadeEcorce,
      'observation': model.observation
    };
  }

  static BmSup30MesureEntity transformToNewEntityMap(
      final int idBmSup30Mesure,
      final int idBmSup30,
      final int idCycle,
      double? diametreIni,
      double? diametreMed,
      double? diametreFin,
      double? diametre130,
      final double longueur,
      bool? ratioHauteur,
      final double contact,
      final bool chablis,
      final int stadeDurete,
      final int stadeEcorce,
      String? observation) {
    return {
      'id_bm_sup_mesure': idBmSup30Mesure,
      'id_bm_sup': idBmSup30,
      'id_cycle': idCycle,
      'diametre_ini': diametreIni,
      'diametre_med': diametreMed,
      'diametre_fin': diametreFin,
      'diametre': diametre130,
      'longueur': longueur,
      'ratio_hauteur': ratioHauteur,
      'contact': contact,
      'chablis': chablis,
      'stade_durete': stadeDurete,
      'stade_ecorce': stadeEcorce,
      'observation': observation,
    };
  }
}
