import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/repository/nomenclatures_repository.dart';
import 'package:dendro3/domain/repository/nomenclatures_types_repository.dart';
import 'package:dendro3/domain/usecase/get_code_ecolo_nomenclature_usecase.dart';

class GetCodeEcoloNomenclaturesUseCaseImpl
    implements GetCodeEcoloNomenclaturesUseCase {
  final NomenclaturesRepository _nomenclatureRepository;
  final NomenclaturesTypesRepository _nomenclatureTypeRepositoryRepository;

  const GetCodeEcoloNomenclaturesUseCaseImpl(
      this._nomenclatureRepository, this._nomenclatureTypeRepositoryRepository);

  @override
  Future<NomenclatureList> execute() async {
    // Recuperer la mnemonique qui correspond au code Ecolo dans la table NomenclatureTypes
    int idType = await _nomenclatureTypeRepositoryRepository
        .getIdTypeNomenclatureFromMnemonique('PSDRF_ECOLOGIE');
    // En déduire la liste des stades de dureté
    return await _nomenclatureRepository.getNomenclaturesFromIdType(idType);
  }
}
