import 'package:dendro3/domain/model/corCyclePlacette.dart'; // import 'package:clean_architecture_corCyclePlacette_app/domain/model/corCyclePlacette_id.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/regeneration_list.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'corCyclePlacette_list.freezed.dart';

@freezed
class CorCyclePlacetteList
    with _$CorCyclePlacetteList
    implements ViewModelObject {
  const factory CorCyclePlacetteList({required List<CorCyclePlacette> values}) =
      _CorCyclePlacetteList;

  const CorCyclePlacetteList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static CorCyclePlacetteList empty() => const CorCyclePlacetteList(values: []);

  @override
  CorCyclePlacetteList addItemToList(final dynamic item) {
    if (item is CorCyclePlacette) {
      return copyWith(values: [...values, item]);
    }
    throw ArgumentError('Item must be of type CorCyclePlacette');
  }

  @override
  CorCyclePlacetteList updateItemInList(final dynamic item) {
    if (item is CorCyclePlacette) {
      return copyWith(
          values: values
              .map((corCyclePlacette) =>
                  corCyclePlacette.idCyclePlacette == item.idCyclePlacette
                      ? item
                      : corCyclePlacette)
              .toList());
    }
    throw ArgumentError('Item must be of type CorCyclePlacette');
  }

  CorCyclePlacetteList updateCorCyclePlacette(
      final CorCyclePlacette newCorCyclePlacette) {
    return copyWith(
        values: values
            .map((corCyclePlacette) => newCorCyclePlacette.idCyclePlacette ==
                    corCyclePlacette.idCyclePlacette
                ? newCorCyclePlacette
                : corCyclePlacette)
            .toList());
  }

  CorCyclePlacetteList removeCorCyclePlacetteById(final int id) => copyWith(
      values: values
          .where((corCyclePlacette) => corCyclePlacette.idCyclePlacette != id)
          .toList());

  TransectList get allTransects {
    return TransectList(
        values: values
            .expand<Transect>((placette) => placette.transects?.values ?? [])
            .toList());
  }

  RegenerationList get allRegenerations {
    return RegenerationList(
        values: values
            .expand<Regeneration>(
                (placette) => placette.regenerations?.values ?? [])
            .toList());
  }

  // Get the corcyclePlacette corresponding to the given idCycle
  CorCyclePlacette? getCorCyclePlacetteByIdCycle(final int idCycle) {
    return values.firstWhereOrNull(
        (corCyclePlacette) => corCyclePlacette.idCycle == idCycle);
  }

  @override
  CorCyclePlacetteList removeItemFromList(final String id) => copyWith(
      values: values
          .where((corCyclePlacette) => corCyclePlacette.idCyclePlacette != id)
          .toList());

  isEmpty() => values.isEmpty;

  bool hasCorCyclePlacetteByIdCycleAndIdplacette(
      final int idCycle, final int idPlacette) {
    return values.any((corCyclePlacette) =>
        corCyclePlacette.idCycle == idCycle &&
        corCyclePlacette.idPlacette == idPlacette);
  }

  bool isLastCycle(CorCyclePlacette corCyclePlacette) {
    return values.last.idCyclePlacette == corCyclePlacette.idCyclePlacette;
  }
}
