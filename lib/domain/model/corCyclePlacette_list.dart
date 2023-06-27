import 'package:dendro3/domain/model/corCyclePlacette.dart'; // import 'package:clean_architecture_corCyclePlacette_app/domain/model/corCyclePlacette_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'corCyclePlacette_list.freezed.dart';

@freezed
class CorCyclePlacetteList with _$CorCyclePlacetteList {
  const factory CorCyclePlacetteList({required List<CorCyclePlacette> values}) =
      _CorCyclePlacetteList;

  const CorCyclePlacetteList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  static CorCyclePlacetteList empty() => const CorCyclePlacetteList(values: []);

  CorCyclePlacetteList addCorCyclePlacette(
          final CorCyclePlacette corCyclePlacette) =>
      copyWith(values: [...values, corCyclePlacette]);

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
}
