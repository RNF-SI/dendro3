import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';
import 'package:dendro3/domain/model/saisisable_object_mesure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30.freezed.dart';

@freezed
class BmSup30 with _$BmSup30 implements SaisisableObjectMesure {
  const factory BmSup30(
      {required String idBmSup30,
      required int idBmSup30Orig,
      required int idPlacette,
      int? idArbre,
      required String codeEssence,
      double? azimut,
      double? distance,
      double? orientation,
      double? azimutSouche,
      double? distanceSouche,
      String? observation,
      BmSup30MesureList? bmsSup30Mesures}) = _BmSup30;

  const BmSup30._();

  @override
  Map<String, dynamic> getAllValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idBmSup30': idBmSup30,
      'idBmSup30Orig': idBmSup30Orig,
      'idPlacette': idPlacette,
      'idArbre': idArbre,
      'codeEssence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'orientation': orientation,
      'azimutSouche': azimutSouche,
      'distanceSouche': distanceSouche,
      'observation': observation,
      'bmsSup30Mesures': bmsSup30Mesures!
          .getValuesMappedFromDisplayedColumnType(
              displayedMesureColumnType: displayedMesureColumnType),
    };
  }

  @override
  Map<String, dynamic> getNoneValues({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idBmSup30Orig': idBmSup30Orig,
      'bmsSup30Mesures': bmsSup30Mesures!
          .getValuesMappedFromDisplayedColumnType(
              displayedMesureColumnType: displayedMesureColumnType),
    };
  }

  @override
  Map<String, dynamic> getReducedValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idBmSup30': idBmSup30,
      'idBmSup30Orig': idBmSup30Orig,
      'idArbre': idArbre,
      'codeEssence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'bmsSup30Mesures': bmsSup30Mesures!
          .getValuesMappedFromDisplayedColumnType(
              displayedMesureColumnType: displayedMesureColumnType),
    };
  }

  @override
  getValuesMappedFromDisplayedColumnType({
    DisplayedColumnType displayedColumnType = DisplayedColumnType.all,
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    switch (displayedColumnType) {
      case DisplayedColumnType.all:
        return getAllValuesMapped(
            displayedMesureColumnType: displayedMesureColumnType);
      case DisplayedColumnType.reduced:
        return getReducedValuesMapped(
            displayedMesureColumnType: displayedMesureColumnType);
      case DisplayedColumnType.none:
        return getNoneValues(
            displayedMesureColumnType: displayedMesureColumnType);
      default:
        return getAllValuesMapped(
            displayedMesureColumnType: displayedMesureColumnType);
    }
  }

  @override
  bool isEqualToMap(Map<String, dynamic> valueMap) {
    return idBmSup30 == valueMap['idBmSup30'];
  }

  static bool getDisplayableColumn(String columnName) {
    return [
      'idBmSup30',
      'idBmSup30Orig',
      'idPlacette',
      'idArbre',
      'codeEssence',
      'azimut',
      'distance',
      // 'orientation',
      // 'azimutSouche',
      // 'distanceSouche',
      'idCycle',
      'diametreIni',
      'diametreMed',
      'diametreFin',
      // 'diametre130',
      'longueur',
      'contact',
      'chablis',
      'stadeDurete',
      'stadeEcorce',
      'observation',
    ].contains(columnName);
  }

  static bool getDisplayableGridTile(String columnName) {
    return [
      'idBmSup30Orig',
      'idPlacette',
      'idArbre',
      'codeEssence',
      'azimut',
      'distance',
      // 'orientation',
      // 'azimutSouche',
      // 'distanceSouche',
      'numCycle',
      'diametreIni',
      'diametreMed',
      'diametreFin',
      // 'diametre130',
      'longueur',
      'contact',
      'chablis',
      'stadeDurete',
      'stadeEcorce',
      'observation',
    ].contains(columnName);
  }

  @override
  BmSup30Mesure getMesureFromIndex(int index) {
    return bmsSup30Mesures![index];
  }

  @override
  BmSup30Mesure? getMesureFromIdCycle(int idCycle) {
    return bmsSup30Mesures!.getMesureFromIdCycle(idCycle);
  }

  static List<Map<String, dynamic>> changeColumnName(List<String> columnNames) {
    String displayName;
    bool isVisible;

    return columnNames.map((columnName) {
      isVisible = true;
      switch (columnName) {
        case 'idBmSup30':
          displayName = 'idBmSup30';
          isVisible = false;
          break;
        case 'idBmSup30Orig':
          displayName = 'id';
          break;
        case 'idArbre':
          displayName = 'NumArbre';
          break;
        case 'codeEssence':
          displayName = 'Essence';
          break;
        case 'azimut':
          displayName = 'Azimut';
          break;
        case 'distance':
          displayName = 'Distance';
          break;
        case 'diametre':
          displayName = 'Diam';
          break;
        case 'longueur':
          displayName = 'Long';
          break;
        case 'idCycle':
          displayName = 'NumCycle';
          break;
        default:
          displayName = columnName;
      }
      return {'title': displayName, 'visible': isVisible};
    }).toList();
  }

  static List<String> changeTitleGridNames(List<String> columnNames) {
    return columnNames.map((columnName) {
      switch (columnName) {
        case 'idBmSup30Orig':
          return 'id';
        case 'idArbre':
          return 'Num arbre';
        case 'codeEssence':
          return 'Essence';
        case 'azimut':
          return 'Azimut';
        case 'distance':
          return 'Distance';
        case 'diametre':
          return 'Diam';
        case 'numCycle':
          return 'NumCycle';
        case 'longueur':
          return 'Longueur';
        case 'stadeDurete':
          return 'Stade Dureté';
        case 'stadeEcorce':
          return 'Stade Ecorce';
        default:
          return columnName;
      }
    }).toList();
  }

  @override
  int getMesureValuesLength() {
    return bmsSup30Mesures!.values.length;
  }
}
