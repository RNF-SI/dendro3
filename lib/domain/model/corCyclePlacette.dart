import 'package:dendro3/domain/model/regeneration_list.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'corCyclePlacette.freezed.dart';

@freezed
class CorCyclePlacette with _$CorCyclePlacette {
  const factory CorCyclePlacette(
      {required int idCyclePlacette,
      required int idCycle,
      required int idPlacette,
      DateTime? dateReleve,
      String? dateIntervention,
      int? annee,
      String? natureIntervention,
      String? gestionPlacette,
      int? idNomenclatureCastor,
      int? idNomenclatureFrottis,
      int? idNomenclatureBoutis,
      double? recouvHerbesBasses,
      double? recouvHerbesHautes,
      double? recouvBuissons,
      double? recouvArbres,
      TransectList? transects,
      RegenerationList? regenerations}) = _CorCyclePlacette;

  const CorCyclePlacette._();
}
