import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'request_storage_permission_usecase.dart';

class RequestStoragePermissionUseCaseImpl
    implements RequestStoragePermissionUseCase {
  @override
  Future<bool> execute() async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;

    print('Current storage permission status: $storageStatus');
    return storageStatus.isGranted;
  }
}
