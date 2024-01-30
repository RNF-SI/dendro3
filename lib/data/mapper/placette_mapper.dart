import 'package:dendro3/data/entity/placettes_entity.dart';
import 'package:dendro3/data/mapper/arbre_list_mapper.dart';
import 'package:dendro3/data/mapper/bmSup30_list_mapper.dart';
import 'package:dendro3/data/mapper/corCyclePlacette_list_mapper.dart';
import 'package:dendro3/data/mapper/mapper_utils.dart';
import 'package:dendro3/data/mapper/repere_list_mapper.dart';
import 'package:dendro3/domain/model/placette.dart';

class PlacetteMapper {
  // static Placette transformToModel(final PlacetteEntity entity) {
  //   return Placette(
  //     id: entity['id'],
  //     name: entity['name'],
  //     idOrganisme: entity['idOrganisme'],
  //     alluvial: entity['alluvial'] == 1,
  //   );
  // }

  static Placette transformFromApiToModel(final PlacetteEntity entity) {
    try {
      return Placette(
        idPlacette:
            entity['id_placette'] ?? logAndReturnNull<int>('id_placette'),
        idDispositif:
            entity['id_dispositif'] ?? logAndReturnNull<int>('id_dispositif'),
        idPlacetteOrig: entity['id_placette_orig'] ??
            logAndReturnNull<String>('id_placette_orig'),
        strate: entity['strate'] ?? logAndReturnNull<int>('strate'),
        pente: entity['pente'] ?? logAndReturnNull<double>('pente'),
        poidsPlacette: entity['poids_placette'] ??
            logAndReturnNull<double>('poids_placette'),
        correctionPente: entity['correction_pente'] ==
            'true', // Assuming the response is 'true' or 'false'
        exposition: entity['exposition'] as int?,
        profondeurApp: entity['profondeur_app'] as String?,
        profondeurHydr: entity['profondeur_hydr'] as double?,
        texture: entity['texture'] as String?,
        habitat: entity['habitat'] as String?,
        station: entity['station'] as String?,
        typologie: entity['typologie'] as String?,
        groupe: entity['groupe'] as String?,
        groupe1: entity['groupe1'] as String?,
        groupe2: entity['groupe2'] as String?,
        refHabitat: entity['ref_habitat'] as String?,
        precisionHabitat: entity['precision_habitat'] as String?,
        refStation: entity['ref_station'] as String?,
        refTypologie: entity['ref_typologie'] as String?,
        descriptifGroupe: entity['descriptif_groupe'] as String?,
        descriptifGroupe1: entity['descriptif_groupe1'] as String?,
        descriptifGroupe2: entity['descriptif_groupe2'] as String?,
        precisionGps: entity['precision_gps'] as String?,
        cheminement: entity['cheminement'] as String?,
        corCyclesPlacettes: entity.containsKey('corCyclesPlacettes')
            ? CorCyclePlacetteListMapper.transformFromApiToModel(
                entity['corCyclesPlacettes'])
            : null,
        arbres: entity.containsKey('arbres')
            ? ArbreListMapper.transformFromApiToModel(entity['arbres'])
            : null,
        bmsSup30: entity.containsKey('bmsSup30')
            ? BmSup30ListMapper.transformFromApiToModel(entity['bmsSup30'])
            : null,
        reperes: entity.containsKey('reperes')
            ? RepereListMapper.transformFromApiToModel(entity['reperes'])
            : null,
      );
    } catch (e) {
      print("Error in transformFromApiToModel: $e");
      print("Entity causing error: ${entity.toString()}");
      // You may want to handle the error or rethrow it
      rethrow;
    }
  }

  static Placette transformFromDBToModel(final PlacetteEntity entity) {
    try {
      return Placette(
          idPlacette: entity['id_placette'],
          idDispositif: entity['id_dispositif'],
          idPlacetteOrig: entity['id_placette_orig'],
          strate: entity['strate'],
          pente: entity['pente'],
          poidsPlacette: entity['poids_placette'],
          correctionPente: entity['correction_pente'] == 't' ? true : false,
          exposition: entity['exposition'],
          profondeurApp: entity['profondeur_app'],
          profondeurHydr: entity['profondeur_hydr'],
          texture: entity['texture'],
          habitat: entity['habitat'],
          station: entity['station'],
          typologie: entity['typologie'],
          groupe: entity['groupe'],
          groupe1: entity['groupe1'],
          groupe2: entity['groupe2'],
          refHabitat: entity['ref_habitat'],
          precisionHabitat: entity['precision_habitat'],
          refStation: entity['ref_station'],
          refTypologie: entity['ref_typologie'],
          descriptifGroupe: entity['descriptif_groupe'],
          descriptifGroupe1: entity['descriptif_groupe1'],
          descriptifGroupe2: entity['descriptif_groupe2'],
          precisionGps: entity['precision_gps'],
          cheminement: entity['cheminement'],
          corCyclesPlacettes: entity.containsKey('corCyclesPlacettes')
              ? CorCyclePlacetteListMapper.transformFromDBToModel(
                  entity['corCyclesPlacettes'])
              : null,
          arbres: entity.containsKey('arbres')
              ? ArbreListMapper.transformFromDBToModel(entity['arbres'])
              : null,
          bmsSup30: entity.containsKey('bmsSup30')
              ? BmSup30ListMapper.transformFromDBToModel(entity['bmsSup30'])
              : null,
          reperes: entity.containsKey('reperes')
              ? RepereListMapper.transformFromDBToModel(entity['reperes'])
              : null);
    } catch (e) {
      print("Error in transformFromDBToModel: $e");
      print("Entity causing error: ${entity.toString()}");
      // You may want to handle the error or rethrow it
      rethrow;
    }
  }

  static PlacetteEntity transformToMap(final Placette model) {
    return {
      'id_placette': model.idPlacette,
      'id_dispositif': model.idDispositif,
      'id_placette_orig': model.idPlacetteOrig,
      'strate': model.strate,
      'pente': model.pente,
      'poids_placette': model.poidsPlacette,
      'correction_pente': model.correctionPente,
      'exposition': model.exposition,
      'profondeur_app': model.profondeurApp,
      'profondeur_hydr': model.profondeurHydr,
      'texture': model.texture,
      'habitat': model.habitat,
      'station': model.station,
      'typologie': model.typologie,
      'groupe': model.groupe,
      'groupe1': model.groupe1,
      'groupe2': model.groupe2,
      'ref_habitat': model.refHabitat,
      'precision_habitat': model.precisionHabitat,
      'ref_station': model.refStation,
      'ref_typologie': model.refTypologie,
      'descriptif_groupe': model.descriptifGroupe,
      'descriptif_groupe1': model.descriptifGroupe1,
      'descriptif_groupe2': model.descriptifGroupe2,
      'precision_gps': model.precisionGps,
      'cheminement': model.cheminement,
      'corCyclesPlacettes': model.corCyclesPlacettes != null
          ? CorCyclePlacetteListMapper.transformToMap(model.corCyclesPlacettes!)
          : null,
      'arbres': model.arbres != null
          ? ArbreListMapper.transformToMap(model.arbres!)
          : null,
      'bmsSup30': model.bmsSup30 != null
          ? BmSup30ListMapper.transformToMap(model.bmsSup30!)
          : null,
      'reperes': model.reperes != null
          ? RepereListMapper.transformToMap(model.reperes!)
          : null
    };
  }

  // static PlacetteEntity transformToNewEntityMap(
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
