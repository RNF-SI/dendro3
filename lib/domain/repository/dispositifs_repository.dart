import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';

abstract class DispositifsRepository {
  Future<DispositifList> getDispositifList();
  Future<Dispositif> createDispositif(
    final String name,
    final int idOrganisme,
    final bool alluvial,
  );
  Future<void> updateDispositif(
    final int id,
    final String name,
    final int idOrganisme,
    final bool alluvial,
  );
  Future<void> deleteDispositif(final int id);
}
