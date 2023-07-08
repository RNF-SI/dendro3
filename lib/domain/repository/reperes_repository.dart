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
}
