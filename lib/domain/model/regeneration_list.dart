import 'package:dendro3/domain/model/regeneration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'regeneration_list.freezed.dart';

@freezed
class RegenerationList with _$RegenerationList {
  const factory RegenerationList({required List<Regeneration> values}) =
      _RegenerationList;

  const RegenerationList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  RegenerationList addRegeneration(final Regeneration regeneration) =>
      copyWith(values: [...values, regeneration]);

  RegenerationList updateRegeneration(final Regeneration newRegeneration) {
    return copyWith(
        values: values
            .map((regeneration) =>
                newRegeneration.idRegeneration == regeneration.idRegeneration
                    ? newRegeneration
                    : regeneration)
            .toList());
  }

  RegenerationList removeRegenerationById(final int id) => copyWith(
      values: values
          .where((regeneration) => regeneration.idRegeneration != id)
          .toList());
}
