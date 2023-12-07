import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';

class GetEssencesUseCaseImpl implements GetEssencesUseCase {
  final EssencesRepository _repository;

  const GetEssencesUseCaseImpl(this._repository);

  @override
  Future<EssenceList> execute() => _repository.getEssenceList();
}
