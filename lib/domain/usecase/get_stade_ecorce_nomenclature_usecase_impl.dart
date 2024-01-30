import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/repository/nomenclatures_repository.dart';
import 'package:dendro3/domain/repository/nomenclatures_types_repository.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase.dart';

class GetStadeEcorceNomenclaturesUseCaseImpl
    implements GetStadeEcorceNomenclaturesUseCase {
  final NomenclaturesRepository _nomenclatureRepository;
  final NomenclaturesTypesRepository _nomenclatureTypeRepositoryRepository;

  const GetStadeEcorceNomenclaturesUseCaseImpl(
      this._nomenclatureRepository, this._nomenclatureTypeRepositoryRepository);

  @override
  Future<NomenclatureList> execute() async {
    // Recuperer la mnemonique qui correspond au stade Ecorce dans la table NomenclatureTypes
    int idType = await _nomenclatureTypeRepositoryRepository
        .getIdTypeNomenclatureFromMnemonique('PSDRF_ECORCE');
    // En déduire la liste des stades de dureté
    return await _nomenclatureRepository.getNomenclaturesFromIdType(idType);
  }
}
