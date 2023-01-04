import 'package:dendro3/domain/model/dispositif_list.dart';

abstract class GetUserDispositifListFromDBUseCase {
  Future<DispositifList> execute(
    final int id,
  );
}
