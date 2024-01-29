import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/model/arbre.dart';

abstract class UpdateArbreAndMesureUseCase {
  Future<Arbre> execute(
    Arbre arbre,
    // final int idArbreOrig,
    final String idArbre,
    final int idArbreOrig,
    final int idPlacette,
    final String codeEssence,
    final double azimut,
    final double distance,
    final bool? taillis,
    final String? observation,
    final String idArbreMesure,
    final int? idCycle,
    int? numCycle,
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
}
