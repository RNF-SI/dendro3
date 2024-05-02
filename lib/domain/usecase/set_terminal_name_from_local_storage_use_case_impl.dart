import 'dart:io' show Platform;
import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/usecase/set_terminal_name_from_local_storage_use_case.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SetTerminalNameFromLocalStorageUseCaseImpl
    implements SetTerminalNameFromLocalStorageUseCase {
  final LocalStorageRepository _repository;

  const SetTerminalNameFromLocalStorageUseCaseImpl(this._repository);

  @override
  Future<void> execute() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String deviceName = 'Unknown Device';

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName =
            '${androidInfo.brand} ${androidInfo.model} - Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName =
            '${iosInfo.utsname.machine} - iOS ${iosInfo.systemVersion}';
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }

    return await _repository.setTerminalName(deviceName);
  }
}
