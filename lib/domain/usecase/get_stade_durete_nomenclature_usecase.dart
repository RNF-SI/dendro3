import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';

abstract class GetStadeDureteNomenclaturesUseCase {
  Future<NomenclatureList> execute();
}
