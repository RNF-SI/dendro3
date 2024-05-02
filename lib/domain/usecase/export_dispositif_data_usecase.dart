import 'package:dendro3/core/helpers/sync_objects.dart';

abstract class ExportDispositifDataUseCase {
  Future<SyncResults> execute(
    final int id,
  );
}
