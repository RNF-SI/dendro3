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
    final int idRepere,
    final int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  );
  Future<void> deleteRepere(final int idRepere);
}
