// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transect_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransectId {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransectIdCopyWith<TransectId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransectIdCopyWith<$Res> {
  factory $TransectIdCopyWith(
          TransectId value, $Res Function(TransectId) then) =
      _$TransectIdCopyWithImpl<$Res, TransectId>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$TransectIdCopyWithImpl<$Res, $Val extends TransectId>
    implements $TransectIdCopyWith<$Res> {
  _$TransectIdCopyWithImpl(this._value, this._then);

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
abstract class _$$_TransectIdCopyWith<$Res>
    implements $TransectIdCopyWith<$Res> {
  factory _$$_TransectIdCopyWith(
          _$_TransectId value, $Res Function(_$_TransectId) then) =
      __$$_TransectIdCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$_TransectIdCopyWithImpl<$Res>
    extends _$TransectIdCopyWithImpl<$Res, _$_TransectId>
    implements _$$_TransectIdCopyWith<$Res> {
  __$$_TransectIdCopyWithImpl(
      _$_TransectId _value, $Res Function(_$_TransectId) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$_TransectId(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TransectId implements _TransectId {
  const _$_TransectId({required this.value});

  @override
  final int value;

  @override
  String toString() {
    return 'TransectId(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransectId &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransectIdCopyWith<_$_TransectId> get copyWith =>
      __$$_TransectIdCopyWithImpl<_$_TransectId>(this, _$identity);
}

abstract class _TransectId implements TransectId {
  const factory _TransectId({required final int value}) = _$_TransectId;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$_TransectIdCopyWith<_$_TransectId> get copyWith =>
      throw _privateConstructorUsedError;
}
