import 'package:dendro3/domain/model/repere.dart';

abstract class UpdateRepereUseCase {
  Future<Repere> execute(
    final String idRepere,
    final int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  );
}
