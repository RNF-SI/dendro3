import 'package:dendro3/core/types/saisie_data_table_types.dart';
import 'package:dendro3/domain/model/displayable_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'placette_list.freezed.dart';

@freezed
class PlacetteList
    with _$PlacetteList
    implements ViewModelObject, DisplayableList {
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

  @override
  PlacetteList updateItemInList(final dynamic item) {
    if (item is Placette) {
      return updatePlacette(item);
    }
    throw ArgumentError('Item must be of type Placette');
  }

  PlacetteList updateItemExpositionPenteAndCorCyclePlacetteInList(
      final dynamic item) {
    if (item is Placette) {
      // update only 2 properties if the item: pente and exposition
      return copyWith(
          values: values
              .map((placette) => placette.idPlacette == item.idPlacette
                  ? placette.copyWith(
                      exposition: item.exposition,
                      pente: item.pente,
                      corCyclesPlacettes: item.corCyclesPlacettes,
                    )
                  : placette)
              .toList());
    }
    throw ArgumentError('Item must be of type Placette');
  }

  @override
  bool isEmpty() {
    return values.isEmpty;
  }

  @override
  addItemToList(item) {
    // TODO: implement addItemToList
    throw UnimplementedError();
  }

  @override
  getFirstElementId() {
    // TODO: implement getFirstElementId
    throw UnimplementedError();
  }

  @override
  getObjectFromId(String id) {
    // TODO: implement getObjectFromId
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>> getObjectMapped(
      {DisplayedColumnType displayedColumnType = DisplayedColumnType.all,
      DisplayedColumnType displayedMesureColumnType =
          DisplayedColumnType.all}) {
    // TODO: implement getObjectMapped
    throw UnimplementedError();
  }

  @override
  removeItemFromList(String id) {
    // TODO: implement removeItemFromList
    throw UnimplementedError();
  }

// TODO: Change searching disp in phone db
  // PlacetteList filterByDownloaded() => copyWith(
  //     values: values.where((placette) => placette.isCompleted).toList());

  // PlacetteList filterByIncomplete() => copyWith(
  //     values: values.where((placette) => !placette.isCompleted).toList());
}
