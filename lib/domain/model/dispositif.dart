import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dispositif.freezed.dart';

@freezed
class Dispositif with _$Dispositif {
  const factory Dispositif(
      {required int id,
      required String name,
      required int idOrganisme,
      required bool alluvial,
      PlacetteList? placettes,
      CycleList? cycles}) = _Dispositif;

  const Dispositif._();

  // factory Dispositif.fromJson(Map<String, dynamic> json) => Dispositif(
  //       id: json["id"],
  //       name: json["name"],
  //       idOrganisme: json["idOrganisme"],
  //       alluvial: json["alluvial"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "idOrganisme": idOrganisme,
  //       "alluvial": alluvial,
  //     };
  // Dispositif complete() => copyWith(isCompleted: true);

  // Dispositif incomplete() => copyWith(isCompleted: false);
}
