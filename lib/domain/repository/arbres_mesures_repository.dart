import 'package:dendro3/domain/model/arbreMesure.dart';

abstract class ArbresMesuresRepository {
  Future<ArbreMesure> insertArbreMesure(
    final String idArbre,
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  );

  Future<ArbreMesure> updateArbreMesure(
    final String idArbreMesure,
    final String idArbre,
    final int? idCycle,
    double? diametre1,
    double? diametre2,
    String? type,
    double? hauteurTotale,
    double? hauteurBranche,
    int? stadeDurete,
    int? stadeEcorce,
    String? liane,
    double? diametreLiane,
    String? coupe,
    final bool limite,
    int? idNomenclatureCodeSanitaire,
    String? codeEcolo,
    final String refCodeEcolo,
    bool? ratioHauteur,
    String? observationMesure,
  );

  // Implements getPreviousCycleMeasure
  Future<ArbreMesure> getPreviousCycleMeasure(
    final String idArbre,
    final int? idCycle,
    int? numCycle,
  );

  Future<void> deleteArbreMesureFromIdArbre(final String idArbre);

  Future<void> deleteArbreMesure(final String idArbreMesure);
}
