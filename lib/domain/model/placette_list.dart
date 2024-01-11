import 'package:dendro3/domain/model/placette.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'placette_list.freezed.dart';

@freezed
class PlacetteList with _$PlacetteList {
  const factory PlacetteList({required List<Placette> values}) = _PlacetteList;

  const PlacetteList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static PlacetteList empty() {
    return const PlacetteList(values: []);
  }

  PlacetteList addPlacette(final Placette placette) =>
      copyWith(values: [...values, placette]);

  PlacetteList updatePlacette(final Placette newPlacette) {
    return copyWith(
        values: values
            .map((placette) => newPlacette.idPlacette == placette.idPlacette
                ? newPlacette
                : placette)
            .toList());
  }

  PlacetteList removePlacetteById(final int id) => copyWith(
      values: values.where((placette) => placette.idPlacette != id).toList());

// TODO: Change searching disp in phone db
  // PlacetteList filterByDownloaded() => copyWith(
  //     values: values.where((placette) => placette.isCompleted).toList());

  // PlacetteList filterByIncomplete() => copyWith(
  //     values: values.where((placette) => !placette.isCompleted).toList());
}
