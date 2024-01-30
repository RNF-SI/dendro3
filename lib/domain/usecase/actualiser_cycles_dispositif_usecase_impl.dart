import 'package:dendro3/domain/repository/cycles_repository.dart';
import 'package:dendro3/domain/usecase/actualiser_cycles_dispositif_usecase.dart';

class ActualiserCyclesDispositifUseCaseImpl
    implements ActualiserCyclesDispositifUseCase {
  final CyclesRepository _repository;

  const ActualiserCyclesDispositifUseCaseImpl(this._repository);

  @override
  Future<void> execute(
    final int id,
  ) =>
      _repository.updateDispositifCycles(id);
}
