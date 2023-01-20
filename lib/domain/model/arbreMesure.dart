import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbreMesure.freezed.dart';

@freezed
class ArbreMesure with _$ArbreMesure implements SaisisableObject {
  const factory ArbreMesure({
    required int idArbreMesure,
    required int idArbre,
    required int idCycle,
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
    required bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    required String refCodeEcolo,
    bool? ratioHauteur,
    String? observation,
  }) = _ArbreMesure;

  const ArbreMesure._();

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
  Map<String, dynamic> getAllValuesMapped() {
    return {
      'idCycle': idCycle,
      'diametre1': diametre1,
      'diametre2': diametre2,
      'type': type,
      'hauteurTotale': hauteurTotale,
      'hauteurBranche': hauteurBranche,
      'stadeDurete': stadeDurete,
      'stadeEcorce': stadeEcorce,
      'liane': liane,
      'diametreLiane': diametreLiane,
      'coupe': coupe,
      'limite': limite,
      'idNomenclatureCodeSanitaire': idNomenclatureCodeSanitaire,
      'codeEcolo': codeEcolo,
      'refCodeEcolo': refCodeEcolo,
      'ratioHauteur': ratioHauteur,
    };
  }

  @override
  Map<String, dynamic> getReducedValuesMapped() {
    return {
      'idCycle': idCycle,
      'diametre1': diametre1,
      'diametre2': diametre2,
      'hauteurTotale': hauteurTotale,
      'hauteurBranche': hauteurBranche,
      'stadeDurete': stadeDurete,
      'stadeEcorce': stadeEcorce,
    };
  }

  @override
  Map<String, dynamic> getNoneValues() {
    return {};
  }
}
