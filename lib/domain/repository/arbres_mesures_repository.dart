import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/dispositif_list.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';

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

  Future<ArbreMesure> updateLastArbreMesureCoupe(
    final String idArbreMesure,
    final String? coupe,
  );

  Future<void> deleteArbreMesureFromIdArbre(final String idArbre);

  Future<void> deleteArbreMesure(final String idArbreMesure);
}
