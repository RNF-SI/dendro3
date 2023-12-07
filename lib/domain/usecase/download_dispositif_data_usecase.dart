import 'package:dendro3/domain/model/dispositif_list.dart';

abstract class DownloadDispositifDataUseCase {
  Future<void> execute(
    final int id,
  );
}
