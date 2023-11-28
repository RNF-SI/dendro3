import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repere.freezed.dart';

@freezed
class Repere with _$Repere implements SaisisableObject {
  const factory Repere(
      {required int idRepere,
      required int idPlacette,
      double? azimut,
      double? distance,
      double? diametre,
      String? repere,
      String? observation}) = _Repere;

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
}
