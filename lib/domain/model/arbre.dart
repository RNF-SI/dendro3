import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/model/saisisable_object_mesure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbre.freezed.dart';

@freezed
class Arbre with _$Arbre implements SaisisableObjectMesure {
  const factory Arbre({
    required String idArbre,
    required int idArbreOrig,
    required int idPlacette,
    required String codeEssence,
    required double azimut,
    required double distance,
    bool? taillis,
    String? observation,
    ArbreMesureList? arbresMesures,
  }) = _Arbre;

  const Arbre._();

  @override
  Map<String, dynamic> getValuesMappedFromDisplayedColumnType({
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
  Map<String, dynamic> getAllValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idArbre': idArbre,
      'idArbreOrig': idArbreOrig,
      'idPlacette': idPlacette,
      'codeEssence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'taillis': taillis,
      'observation': observation,
      'arbresMesures': arbresMesures!.getValuesMappedFromDisplayedColumnType(
          displayedMesureColumnType: displayedMesureColumnType),
    };
  }

  @override
  Map<String, dynamic> getReducedValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idArbre': idArbre,
      'idArbreOrig': idArbreOrig,
      'codeEssence': codeEssence,
      'azimut': azimut,
      'distance': distance,
      'taillis': taillis,
      'arbresMesures': arbresMesures!.getValuesMappedFromDisplayedColumnType(
          displayedMesureColumnType: displayedMesureColumnType),
    };
  }

  @override
  Map<String, dynamic> getNoneValues({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idArbreOrig': idArbreOrig,
      'arbresMesures': arbresMesures!.getValuesMappedFromDisplayedColumnType(
          displayedMesureColumnType: displayedMesureColumnType),
    };
  }

  @override
  bool isEqualToMap(Map<String, dynamic> valueMap) {
    return idArbre == valueMap['idArbre'];
  }

  static bool getDisplayableColumn(String columnName) {
    return [
      'idArbre',
      'idArbreOrig',
      'codeEssence',
      'azimut',
      'distance',
      'taillis',
      'idCycle',
      'diametre1',
      'diametre2',
      'type',
      'hauteurTotale',
      'stadeDurete',
      'stadeEcorce',
      'coupe',
      'limite',
      'codeEcolo',
      'refCodeEcolo',
    ].contains(columnName);
  }

  static bool getDisplayableGridTile(String columnName) {
    return [
      'idArbreOrig',
      'codeEssence',
      'azimut',
      'distance',
      'taillis',
      'numCycle',
      'diametre1',
      'diametre2',
      'type',
      'hauteurTotale',
      'stadeDurete',
      'stadeEcorce',
      'coupe',
      'limite',
      'codeEcolo',
      'refCodeEcolo',
    ].contains(columnName);
  }

  @override
  ArbreMesure getMesureFromIndex(int index) {
    return arbresMesures![index];
  }

  @override
  ArbreMesure? getMesureFromIdCycle(int idCycle) {
    return arbresMesures!.getMesureFromIdCycle(idCycle);
  }

  static List<Map<String, dynamic>> changeColumnName(List<String> columnNames) {
    String displayName;
    bool isVisible;

    return columnNames.map((columnName) {
      isVisible = true;
      switch (columnName) {
        case 'idArbre':
          displayName = 'idArbre';
          isVisible = false; // Assuming you want to hide this column
          break;
        case 'idArbreOrig':
          displayName = 'Num';
          break;
        case 'codeEssence':
          displayName = 'Ess';
          break;
        case 'azimut':
          displayName = 'Azim';
          break;
        case 'distance':
          displayName = 'Dist';
          break;
        case 'idCycle':
          displayName = 'NumCycle';
          break;
        case 'diametre1':
          displayName = 'Diam1';
          break;
        case 'type':
          displayName = 'Type';
          break;
        case 'taillis':
          displayName = 'Taillis';
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
        case 'idArbreOrig':
          return 'Num';
        case 'codeEssence':
          return 'Essence';
        case 'azimut':
          return 'Azimut';
        case 'distance':
          return 'Distance';
        case 'diametre1':
          return 'Diamètre 1';
        case 'type':
          return 'Type';
        case 'numCycle':
          return 'NumCycle';
        case 'taillis':
          return 'Taillis';
        case 'observation':
          return 'Observation';
        case 'hauteurTotale':
          return 'Hauteur';
        case 'diametre2':
          return 'Diametre 2';
        case 'stadeDurete':
          return 'Stade Dureté';
        case 'stadeEcorce':
          return 'Stade Ecorce';
        default:
          return columnName;
      }
    }).toList();
  }

  getMesureValuesLength() {
    return arbresMesures!.values.length;
  }
}
