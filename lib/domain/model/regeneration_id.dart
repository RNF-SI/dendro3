import 'package:freezed_annotation/freezed_annotation.dart';

part 'regeneration_id.freezed.dart';

@freezed
class RegenerationId with _$RegenerationId {
  const factory RegenerationId({required int value}) = _RegenerationId;
}
