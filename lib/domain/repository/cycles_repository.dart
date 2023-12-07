import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';

abstract class CyclesRepository {
  Future<void> updateDispositifCycles(
    final int id,
  );
}
