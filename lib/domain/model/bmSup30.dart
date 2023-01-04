import 'package:dendro3/domain/model/bmSup30Mesure_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bmSup30.freezed.dart';

@freezed
class BmSup30 with _$BmSup30 {
  const factory BmSup30(
      {required int idBmSup30,
      required int idBmSup30Orig,
      required int idPlacette,
      required int idArbre,
      required String codeEssence,
      required double azimut,
      required double distance,
      double? orientation,
      double? azimutSouche,
      double? distanceSouche,
      String? observation,
      BmSup30MesureList? bmsSup30Mesures}) = _BmSup30;

  const BmSup30._();
}
