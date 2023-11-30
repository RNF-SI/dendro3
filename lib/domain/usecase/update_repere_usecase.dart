import 'package:dendro3/domain/model/repere.dart';

abstract class UpdateRepereUseCase {
  Future<Repere> execute(
    final int idRepere,
    final int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  );
}
