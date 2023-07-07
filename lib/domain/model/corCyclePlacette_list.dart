import 'package:dendro3/domain/model/corCyclePlacette.dart'; // import 'package:clean_architecture_corCyclePlacette_app/domain/model/corCyclePlacette_id.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/model/transect_list.dart';
import 'package:dendro3/domain/model/viewmodel_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
}
