import 'package:dendro3/domain/model/repere.dart';

abstract class ReperesRepository {
  Future<Repere> insertRepere(
    final int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  );
  Future<Repere> updateRepere(
    final String idRepere,
    final int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  );
  Future<void> deleteRepere(final String idRepere);

  Future<void> deleteRepereFromPlacetteId(final int placetteId);
}
