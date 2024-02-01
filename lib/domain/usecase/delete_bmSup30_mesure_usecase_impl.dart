import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_mesure_usecase.dart';

class DeleteBmSup30MesureUseCaseImpl implements DeleteBmSup30MesureUseCase {
  final BmsSup30MesuresRepository _bmSup30MesuresRepository;

  DeleteBmSup30MesureUseCaseImpl(this._bmSup30MesuresRepository);

  @override
  Future<BmSup30> execute(
    BmSup30 bmSup30,
    String bmSup30MesureId,
  ) async {
    await _bmSup30MesuresRepository.deleteBmsSup30Mesure(bmSup30MesureId);

    List<BmSup30Mesure> updatedMesures =
        List.from(bmSup30.bmsSup30Mesures!.values);

    updatedMesures
        .removeWhere((mesure) => mesure.idBmSup30Mesure == bmSup30MesureId);

    return bmSup30.copyWith(
        bmsSup30Mesures: BmSup30MesureList(values: updatedMesures));
  }
}
