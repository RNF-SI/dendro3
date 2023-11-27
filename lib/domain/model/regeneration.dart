import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'regeneration.freezed.dart';

@freezed
class Regeneration with _$Regeneration implements SaisisableObject {
  const factory Regeneration(
      {required int idRegeneration,
      required int idCyclePlacette,
      required int sousPlacette,
      required String codeEssence,
      required double recouvrement,
      required int classe1,
      required int classe2,
      required int classe3,
      required bool taillis,
      required bool abroutissement,
      int? idNomenclatureAbroutissement,
      String? observation}) = _Regeneration;

  const Regeneration._();

  @override
  Map<String, dynamic> getAllValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idRegeneration': idRegeneration,
      'idCyclePlacette': idCyclePlacette,
      'sousPlacette': sousPlacette,
      'codeEssence': codeEssence,
      'recouvrement': recouvrement,
      'classe1': classe1,
      'classe2': classe2,
      'classe3': classe3,
      'taillis': taillis,
      'abroutissement': abroutissement,
      'idNomenclatureAbroutissement': idNomenclatureAbroutissement,
      'observation': observation
    };
  }

  @override
  Map<String, dynamic> getNoneValues({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idRegeneration': idRegeneration,
    };
  }

  @override
  Map<String, dynamic> getReducedValuesMapped({
    DisplayedColumnType displayedMesureColumnType = DisplayedColumnType.all,
  }) {
    return {
      'idRegeneration': idRegeneration,
      'idCyclePlacette': idCyclePlacette,
      'sousPlacette': sousPlacette,
      'codeEssence': codeEssence,
      'taillis': taillis,
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
}
