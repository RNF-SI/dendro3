
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nomenclature.freezed.dart';

@freezed
class Nomenclature with _$Nomenclature {
  const factory Nomenclature({
    required int idNomenclature,
    required int idType,
    required String cdNomenclature,
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
    int? idBroader,
    String? hierarchy,
    bool? active,
  }) = _Nomenclature;

  const Nomenclature._();

  bool codeEcoloFilterByLabelDefault(String filter) {
    return labelDefault.toLowerCase().contains(filter.toLowerCase());
  }
}
