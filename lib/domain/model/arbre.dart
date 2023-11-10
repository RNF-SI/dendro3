import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbre.freezed.dart';

@freezed
class Arbre with _$Arbre implements SaisisableObject {
  const factory Arbre(
      {required int idArbre,
      required int idArbreOrig,
      required int idPlacette,
      required String codeEssence,
      required double azimut,
      required double distance,
      bool? taillis,
      String? observation,
      ArbreMesureList? arbresMesures}) = _Arbre;

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
}
