import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle.freezed.dart';

@freezed
class Cycle with _$Cycle {
  const factory Cycle(
      {required int idCycle,
      required int idDispositif,
      required int numCycle,
      DateTime? dateDebut,
      DateTime? dateFin,
      String? monitor,
      CorCyclePlacetteList? corCyclesPlacettes}) = _Cycle;

  const Cycle._();
}
