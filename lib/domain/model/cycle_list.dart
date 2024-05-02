import 'package:dendro3/domain/model/cycle.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle_list.freezed.dart';

@freezed
class CycleList with _$CycleList {
  const factory CycleList({required List<Cycle> values}) = _CycleList;

  const CycleList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  CycleList addCycle(final Cycle cycle) => copyWith(values: [...values, cycle]);

  CycleList updateCycle(final Cycle newCycle) {
    return copyWith(
        values: values
            .map(
                (cycle) => newCycle.idCycle == cycle.idCycle ? newCycle : cycle)
            .toList());
  }

  CycleList removeCycleById(final int id) =>
      copyWith(values: values.where((cycle) => cycle.idCycle != id).toList());

  Cycle? findCycleById(final int idCycle) {
    return values.firstWhere(
      (cycle) => cycle.idCycle == idCycle,
    );
  }

  Cycle findIdOfCycleWithLargestNumCycle() {
    Cycle? cycleWithLargestNumCycle = values.reduce(
        (current, next) => current.numCycle > next.numCycle ? current : next);
    return cycleWithLargestNumCycle;
  }

  bool cyclesAreTerminated() {
    // Find the cycle with the largest numCycle
    Cycle cycleWithLargestNumCycle = findIdOfCycleWithLargestNumCycle();

    // Check if the `datefin` attribute of the found cycle is not null
    return cycleWithLargestNumCycle.isTerminated();
  }
}
