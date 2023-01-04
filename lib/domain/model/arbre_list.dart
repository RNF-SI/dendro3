import 'package:dendro3/domain/model/arbre.dart'; // import 'package:clean_architecture_arbre_app/domain/model/arbre_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbre_list.freezed.dart';

@freezed
class ArbreList with _$ArbreList {
  const factory ArbreList({required List<Arbre> values}) = _ArbreList;

  const ArbreList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  ArbreList addArbre(final Arbre arbre) => copyWith(values: [...values, arbre]);

  ArbreList updateArbre(final Arbre newArbre) {
    return copyWith(
        values: values
            .map(
                (arbre) => newArbre.idArbre == arbre.idArbre ? newArbre : arbre)
            .toList());
  }

  ArbreList removeArbreById(final int id) =>
      copyWith(values: values.where((arbre) => arbre.idArbre != id).toList());
}
