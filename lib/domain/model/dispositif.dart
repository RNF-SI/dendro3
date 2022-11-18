import 'package:freezed_annotation/freezed_annotation.dart';

part 'dispositif.freezed.dart';

@freezed
class Dispositif with _$Dispositif {
  const factory Dispositif(
      {required int id,
      required String name,
      required int idOrganisme,
      required bool alluvial}) = _Dispositif;

  const Dispositif._();

  // Dispositif complete() => copyWith(isCompleted: true);

  // Dispositif incomplete() => copyWith(isCompleted: false);
}
