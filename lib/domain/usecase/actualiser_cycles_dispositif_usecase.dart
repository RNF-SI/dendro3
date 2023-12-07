import 'package:dendro3/domain/model/dispositif.dart';

abstract class ActualiserCyclesDispositifUseCase {
  Future<void> execute(
    final int id,
  );
}
