import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repere.freezed.dart';

@freezed
class Repere with _$Repere implements SaisisableObject {
  const factory Repere({
    required String idRepere,
    required int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? createdOn,
    String? updatedOn,
  }) = _Repere;

  const Repere._();

  @override
  Map<String, dynamic> getAllValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idRepere': idRepere,
      'idPlacette': idPlacette,
      'azimut': azimut,
      'distance': distance,
      'diametre': diametre,
      'repere': repere,
      'observation': observation
    };
  }

  @override
  Map<String, dynamic> getNoneValues({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idRepere': idRepere,
    };
  }

  @override
  Map<String, dynamic> getReducedValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idRepere': idRepere,
      'idPlacette': idPlacette,
      'repere': repere,
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
    return idRepere == valueMap['idRepere'];
  }

  static bool getDisplayableColumn(String columnName) {
    return [
      'idRepere',
      // 'idPlacette',
      'azimut',
      'distance',
      'diametre',
      'repere',
      'observation'
    ].contains(columnName);
  }

  static List<Map<String, dynamic>> changeColumnName(List<String> columnNames) {
    String displayName;
    bool isVisible;

    return columnNames.map((columnName) {
      isVisible = true;
      switch (columnName) {
        case 'idRepere':
          displayName = 'id';
          // isVisible = false;
          break;
        case 'azimut':
          displayName = 'Azimut';
          break;
        case 'distance':
          displayName = 'Dist';
          break;
        case 'diametre':
          displayName = 'Diam';
          break;
        case 'repere':
          displayName = 'Repere';
          break;
        case 'observation':
          displayName = 'Obs';
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
        case 'idRepere':
          return 'idRepere';
        case 'azimut':
          return 'Azimut';
        case 'distance':
          return 'Dist';
        case 'diametre':
          return 'Diam';
        case 'repere':
          return 'Repere';
        case 'observation':
          return 'Obs';
        default:
          return columnName;
      }
    }).toList();
  }
}
