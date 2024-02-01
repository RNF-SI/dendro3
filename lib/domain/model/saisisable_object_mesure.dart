import 'package:dendro3/domain/model/saisisable_object.dart';

abstract class SaisisableObjectMesure implements SaisisableObject {
  dynamic getMesureFromIndex(int index);
  getMesureFromIdCycle(int idCycle);
  getMesureValuesLength();
}
