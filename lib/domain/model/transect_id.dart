import 'package:freezed_annotation/freezed_annotation.dart';

part 'transect_id.freezed.dart';

@freezed
class TransectId with _$TransectId {
  const factory TransectId({required int value}) = _TransectId;
}
