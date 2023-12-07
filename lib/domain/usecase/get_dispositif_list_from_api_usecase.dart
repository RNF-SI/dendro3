import 'package:dendro3/domain/model/dispositif_list.dart';

abstract class GetDispositifListFromApiUseCase {
  Future<DispositifList> execute();
}
