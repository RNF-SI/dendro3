import 'package:dendro3/domain/model/bmSup30.dart';

abstract class DeleteBmSup30MesureUseCase {
  Future<BmSup30> execute(
    BmSup30 bmSup30,
    String id,
  );
}
