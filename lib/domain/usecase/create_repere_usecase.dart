import 'package:dendro3/domain/model/repere.dart';

abstract class CreateRepereUseCase {
  Future<Repere> execute(
    final int idPlacette,
    double? azimut,
    double? distance,
    double? diametre,
    String? repere,
    String? observation,
  );
}
