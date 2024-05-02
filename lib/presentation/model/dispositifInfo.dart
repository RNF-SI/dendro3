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
    @Default(0.0)
    double downloadProgress, // Default to 0.0, indicating no progress
  }) = _DispositifInfo;

  const DispositifInfo._();
}
