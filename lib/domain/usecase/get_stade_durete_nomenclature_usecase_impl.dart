import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/repository/nomenclatures_repository.dart';
import 'package:dendro3/domain/repository/nomenclatures_types_repository.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase.dart';

class GetStadeDureteNomenclaturesUseCaseImpl
    implements GetStadeDureteNomenclaturesUseCase {
  final NomenclaturesRepository _nomenclatureRepository;
  final NomenclaturesTypesRepository _nomenclatureTypeRepositoryRepository;

  const GetStadeDureteNomenclaturesUseCaseImpl(
      this._nomenclatureRepository, this._nomenclatureTypeRepositoryRepository);

  @override
  Future<NomenclatureList> execute() async {
    // Recuperer la mnemonique qui correspond au stade Durete dans la table NomenclatureTypes
    int idType = await _nomenclatureTypeRepositoryRepository
        .getIdTypeNomenclatureFromMnemonique('PSDRF_DURETE');
    // En déduire la liste des stades de dureté
    return await _nomenclatureRepository.getNomenclaturesFromIdType(idType);
  }
}
