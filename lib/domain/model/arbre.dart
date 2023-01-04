import 'package:dendro3/domain/model/arbreMesure_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbre.freezed.dart';

@freezed
class Arbre with _$Arbre {
  const factory Arbre(
      {required int idArbre,
      required int idArbreOrig,
      required int idPlacette,
      required String codeEssence,
      required double azimut,
      required double distance,
      bool? taillis,
      String? observation,
      ArbreMesureList? arbresMesures}) = _Arbre;

  const Arbre._();
}
