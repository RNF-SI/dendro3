import 'package:dendro3/core/helpers/export_objects.dart';

abstract class ExportDispositifDataUseCase {
  Future<ExportResults> execute(
    final int id,
    final String? lastSyncTime,
  );
}
