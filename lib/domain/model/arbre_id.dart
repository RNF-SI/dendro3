import 'package:freezed_annotation/freezed_annotation.dart';

part 'arbre_id.freezed.dart';

@freezed
class ArbreId with _$ArbreId {
  const factory ArbreId({required int value}) = _ArbreId;
}
