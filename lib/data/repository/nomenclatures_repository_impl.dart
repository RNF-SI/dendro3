
import 'package:dendro3/data/datasource/interface/database/nomenclatures_database.dart';
import 'package:dendro3/data/mapper/nomenclature_list_mapper.dart';
// import 'package:dendro3/domain/model/nomenclature_id.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/repository/nomenclatures_repository.dart';

class NomenclaturesRepositoryImpl implements NomenclaturesRepository {
  final NomenclaturesDatabase database;

  const NomenclaturesRepositoryImpl(this.database);

  @override
  Future<NomenclatureList> getNomenclatureList() async {
    final nomenclatureListEntity = await database.getNomenclatureList();
    return NomenclatureListMapper.transformToModel(nomenclatureListEntity);
  }

  @override
  Future<NomenclatureList> getNomenclaturesFromIdType(int idType) async {
    final nomenclatureListEntity =
        await database.getNomenclatureListFromIdType(idType);
    return NomenclatureListMapper.transformToModel(nomenclatureListEntity);
  }
}
