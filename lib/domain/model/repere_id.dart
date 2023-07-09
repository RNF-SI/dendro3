import 'package:freezed_annotation/freezed_annotation.dart';

part 'repere_id.freezed.dart';

@freezed
class RepereId with _$RepereId {
  const factory RepereId({required int value}) = _RepereId;
}
