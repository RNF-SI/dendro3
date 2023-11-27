import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30.freezed.dart';

@freezed
class BmSup30 with _$BmSup30 implements SaisisableObject {
  const factory BmSup30(
      {required int idBmSup30,
      required int idBmSup30Orig,
      required int idPlacette,
      required int idArbre,
      required String codeEssence,
      required double azimut,
      required double distance,
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
}
