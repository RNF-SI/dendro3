import 'package:dendro3/domain/model/dispositif_list.dart';

abstract class GetUserDispositifListFromAPIUseCase {
  Future<DispositifList> execute(
    final int id,
  );
}
