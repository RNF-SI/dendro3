import 'package:dendro3/domain/model/nomenclature_list.dart';

abstract class GetStadeEcorceNomenclaturesUseCase {
  Future<NomenclatureList> execute();
}
