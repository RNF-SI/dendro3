import 'package:dendro3/domain/model/dispositif_list.dart';

abstract class GetDispositifListUseCase {
  Future<DispositifList> execute();
}
