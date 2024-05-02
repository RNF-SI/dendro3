
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nomenclatureType.freezed.dart';

@freezed
class NomenclatureType with _$NomenclatureType {
  const factory NomenclatureType({
    required int idType,
    String? mnemonique,
    required String labelDefault,
    String? definitionDefault,
    required String labelFr,
    String? definitionFr,
    String? labelEn,
    String? definitionEn,
    String? labelEs,
    String? definitionEs,
    String? labelDe,
    String? definitionDe,
    String? labelIt,
    String? definitionIt,
    String? source,
    String? statut,
  }) = _NomenclatureType;

  const NomenclatureType._();
}
