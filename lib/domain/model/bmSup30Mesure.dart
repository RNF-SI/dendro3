import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30Mesure.freezed.dart';

@freezed
class BmSup30Mesure with _$BmSup30Mesure implements SaisisableObject {
  const factory BmSup30Mesure(
      {required String idBmSup30Mesure,
      required String idBmSup30,
      required int idCycle,
      double? diametreIni,
      double? diametreMed,
      double? diametreFin,
      double? diametre130,
      required double longueur,
      bool? ratioHauteur,
      required double contact,
      required bool chablis,
      required int stadeDurete,
      required int stadeEcorce,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? createdBy,
      String? updatedBy,
      String? createdOn,
      String? updatedOn,
      String? observation}) = _BmSup30Mesure;

  const BmSup30Mesure._();

  @override
  Map<String, dynamic> getAllValuesMapped() {
    return {
      'idBmSup30Mesure': idBmSup30Mesure,
      'idBmSup30': idBmSup30,
      'idCycle': idCycle,
      'diametreIni': diametreIni,
      'diametreMed': diametreMed,
      'diametreFin': diametreFin,
      'diametre130': diametre130,
      'longueur': longueur,
      'ratioHauteur': ratioHauteur,
      'contact': contact,
      'chablis': chablis,
      'stadeDurete': stadeDurete,
      'stadeEcorce': stadeEcorce,
      'observation': observation
    };
  }

  @override
  Map<String, dynamic> getNoneValues() {
    return {};
  }

  @override
  Map<String, dynamic> getReducedValuesMapped() {
    return {
      'idCycle': idCycle,
      'diametreMed': diametreMed,
      'longueur': longueur,
    };
  }

  @override
  Map<String, dynamic> getValuesMappedFromDisplayedColumnType({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    switch (displayedMesureColumnType) {
      case DisplayedColumnType.all:
        return getAllValuesMapped();
      case DisplayedColumnType.reduced:
        return getReducedValuesMapped();
      case DisplayedColumnType.none:
        return getNoneValues();
      default:
        return getAllValuesMapped();
    }
  }

  @override
  bool isEqualToMap(Map<String, dynamic> valueMap) {
    return idBmSup30Mesure == valueMap['idBmSup30Mesure'];
  }
}
