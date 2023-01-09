import 'package:dendro3/domain/model/dispositif.dart';

abstract class GetDispositifUseCase {
  Future<Dispositif> execute(
    final int id,
  );
}
