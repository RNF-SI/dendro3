import 'package:dendro3/domain/model/arbre.dart';

abstract class ArbresRepository {
  Future<Arbre> insertArbre(
    // final int idArbreOrig,
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
  );
}
