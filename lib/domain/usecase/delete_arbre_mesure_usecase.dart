import 'package:dendro3/domain/model/arbre.dart';

abstract class DeleteArbreMesureUseCase {
  Future<Arbre> execute(
    Arbre arbre,
    String id,
    String arbreId,
    final int? idCycle,
    int? numCycle,
  );
}
