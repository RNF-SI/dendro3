import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/bmSup30_list.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/repere_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'placette.freezed.dart';

@freezed
class Placette with _$Placette {
  const factory Placette(
      {required int idPlacette,
      required int idDispositif,
      required String idPlacetteOrig,
      required int strate,
      required double pente,
      required double poidsPlacette,
      required bool correctionPente,
      int? exposition,
      String? profondeurApp,
      double? profondeurHydr,
      String? texture,
      String? habitat,
      String? station,
      String? typologie,
      String? groupe,
      String? groupe1,
      String? groupe2,
      String? refHabitat,
      String? precisionHabitat,
      String? refStation,
      String? refTypologie,
      String? descriptifGroupe,
      String? descriptifGroupe1,
      String? descriptifGroupe2,
      String? precisionGps,
      String? cheminement,
      CorCyclePlacetteList? corCyclesPlacettes,
      ArbreList? arbres,
      BmSup30List? bmsSup30,
      RepereList? reperes}) = _Placette;

  const Placette._();

  Placette updateCorCyclesPlacettes(
      final CorCyclePlacetteList? newCorCyclesPlacettesList) {
    return copyWith(corCyclesPlacettes: newCorCyclesPlacettesList);
  }
}
