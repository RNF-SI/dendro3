import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/presentation/state/download_status.dart';
// import 'package:dendro3/domain/model/placette_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dispositifInfo.freezed.dart';

@freezed
class DispositifInfo with _$DispositifInfo {
  const factory DispositifInfo({
    required Dispositif dispositif,
    required DownloadStatus downloadStatus,
  }) = _DispositifInfo;

  const DispositifInfo._();

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
