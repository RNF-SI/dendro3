import 'package:dendro3/domain/model/dispositif.dart';

abstract class DeleteDispositifUseCase {
  Future<void> execute(
    final int id,
  );
}
