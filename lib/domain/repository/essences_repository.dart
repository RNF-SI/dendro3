import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';

abstract class EssencesRepository {
  Future<EssenceList> getEssenceList();
}
