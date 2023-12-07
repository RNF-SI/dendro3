import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/essence_list.dart';

abstract class GetEssencesUseCase {
  Future<EssenceList> execute();
}
