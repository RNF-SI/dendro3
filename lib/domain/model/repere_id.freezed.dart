// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repere_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RepereId {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepereIdCopyWith<RepereId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepereIdCopyWith<$Res> {
  factory $RepereIdCopyWith(RepereId value, $Res Function(RepereId) then) =
      _$RepereIdCopyWithImpl<$Res, RepereId>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$RepereIdCopyWithImpl<$Res, $Val extends RepereId>
    implements $RepereIdCopyWith<$Res> {
  _$RepereIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepereIdImplCopyWith<$Res>
    implements $RepereIdCopyWith<$Res> {
  factory _$$RepereIdImplCopyWith(
          _$RepereIdImpl value, $Res Function(_$RepereIdImpl) then) =
      __$$RepereIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$RepereIdImplCopyWithImpl<$Res>
    extends _$RepereIdCopyWithImpl<$Res, _$RepereIdImpl>
    implements _$$RepereIdImplCopyWith<$Res> {
  __$$RepereIdImplCopyWithImpl(
      _$RepereIdImpl _value, $Res Function(_$RepereIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$RepereIdImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RepereIdImpl implements _RepereId {
  const _$RepereIdImpl({required this.value});

  @override
  final int value;

  @override
  String toString() {
    return 'RepereId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepereIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepereIdImplCopyWith<_$RepereIdImpl> get copyWith =>
      __$$RepereIdImplCopyWithImpl<_$RepereIdImpl>(this, _$identity);
}

abstract class _RepereId implements RepereId {
  const factory _RepereId({required final int value}) = _$RepereIdImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$RepereIdImplCopyWith<_$RepereIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
