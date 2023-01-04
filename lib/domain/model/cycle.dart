import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle.freezed.dart';

@freezed
class Cycle with _$Cycle {
  const factory Cycle(
      {required int idCycle,
      required int idDispositif,
      required int numCycle,
      required int coeff,
      required DateTime dateDebut,
      required DateTime dateFin,
      required double diamLim,
      String? monitor,
      CorCyclePlacetteList? corCyclesPlacettes}) = _Cycle;

  const Cycle._();
}
