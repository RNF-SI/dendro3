import 'package:dendro3/domain/model/arbre.dart';

abstract class DeleteArbreMesureUseCase {
  Future<Arbre> execute(
    Arbre arbre,
    int id,
    int arbreId,
    final int? idCycle,
    int? numCycle,
  );
}
