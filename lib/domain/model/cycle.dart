import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle.freezed.dart';

@freezed
class Cycle with _$Cycle {
  const factory Cycle(
      {required int idCycle,
      required int idDispositif,
      required int numCycle,
      int? coeff,
      DateTime? dateDebut,
      DateTime? dateFin,
      double? diamLim,
      String? monitor,
      CorCyclePlacetteList? corCyclesPlacettes}) = _Cycle;

  const Cycle._();
}
