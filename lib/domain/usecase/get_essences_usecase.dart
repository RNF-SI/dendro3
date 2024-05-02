import 'package:dendro3/domain/model/essence_list.dart';

abstract class GetEssencesUseCase {
  Future<EssenceList> execute();
}
