import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transect.freezed.dart';

@freezed
class Transect with _$Transect implements SaisisableObject {
  const factory Transect({
    required int idTransect,
    required int idCyclePlacette,
    required int idTransectOrig,
    required String codeEssence,
    required String refTransect,
    double? distance,
    double? orientation,
    double? azimutSouche,
    double? distanceSouche,
    required double diametre,
    double? diametre130,
    bool? ratioHauteur,
    required bool contact,
    required double angle,
    required bool chablis,
    required int stadeDurete,
    required int stadeEcorce,
    String? observation,
  }) = _Transect;

  const Transect._();

  @override
  Map<String, dynamic> getAllValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idTransect': idTransect,
      'idCyclePlacette': idCyclePlacette,
      'idTransectOrig': idTransectOrig,
      'codeEssence': codeEssence,
      'refTransect': refTransect,
      'distance': distance,
      'orientation': orientation,
      'azimutSouche': azimutSouche,
      'distanceSouche': distanceSouche,
      'diametre': diametre,
      'diametre130': diametre130,
      'ratioHauteur': ratioHauteur,
      'contact': contact,
      'angle': angle,
      'chablis': chablis,
      'stadeDurete': stadeDurete,
      'stadeEcorce': stadeEcorce,
      'observation': observation,
    };
  }

  @override
  Map<String, dynamic> getNoneValues({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idTransectOrig': idTransectOrig,
    };
  }

  @override
  Map<String, dynamic> getReducedValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idTransect': idTransect,
      'idTransectOrig': idTransectOrig,
      'idCyclePlacette': idCyclePlacette,
      'codeEssence': codeEssence,
      'diametre': diametre,
    };
  }

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
  bool isEqualToMap(Map<String, dynamic> valueMap) {
    return idTransect == valueMap['idTransect'];
  }

  static bool getDisplayableColumn(String columnName) {
    return [
      'idTransect',
      'idCyclePlacette',
      // 'idTransectOrig',
      'codeEssence',
      'refTransect',
      // 'distance',
      // 'orientation',
      // 'azimutSouche',
      // 'distanceSouche',
      'diametre',
      // 'diametre130',
      // 'ratioHauteur',
      'contact',
      'angle',
      'chablis',
      'stadeDurete',
      'stadeEcorce',
      'observation',
    ].contains(columnName);
  }

  static List<String> changeColumnName(List<String> columnNames) {
    return columnNames.map((columnName) {
      switch (columnName) {
        // case 'idTransect':
        //   return 'idTransectOrigine';
        case 'idCyclePlacette':
          return 'NumCycle';
        case 'codeEssence':
          return 'Ess';
        case 'diametre':
          return 'Diam';
        default:
          return columnName;
      }
    }).toList();
  }

  static List<String> changeTitleGridNames(List<String> columnNames) {
    return columnNames.map((columnName) {
      switch (columnName) {
        case 'idTransect':
          return 'idTransectOrigine';
        case 'idCyclePlacette':
          return 'NumCycle';
        case 'codeEssence':
          return 'Essence';
        case 'refTransect':
          return 'Transect';
        case 'distance':
          return 'Distance';
        case 'diametre':
          return 'Diamètre';
        case 'contact':
          return 'Contact';
        case 'angle':
          return 'Angle';
        case 'chablis':
          return 'Chablis';
        case 'StadeDurete':
          return 'Stade Dureté';
        case 'stadeEcorce':
          return 'Stade Ecorce';
        case 'observation':
          return 'Observation';
        default:
          return columnName;
      }
    }).toList();
  }
}
