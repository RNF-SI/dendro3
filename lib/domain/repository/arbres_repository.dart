import 'package:dendro3/domain/model/arbre.dart';

abstract class ArbresRepository {
  Future<Arbre> insertArbre(
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
  );

  Future<Arbre> updateArbre(
    final String idArbre,
    final int idArbreOrig,
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
  );

  Future<void> deleteArbre(final String idArbre);

  Future<List<String>> getArbreIdsForPlacette(final int idPlacette);
  Future<void> deleteArbreAndArbreMesureFromIdArbre(final String idArbre);

  Future<void> actualizeArbreIdArbreOrigAfterSync(
      final List<Map<String, dynamic>> arbresList);
}
