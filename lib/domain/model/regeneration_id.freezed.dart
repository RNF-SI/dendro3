// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regeneration_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegenerationId {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegenerationIdCopyWith<RegenerationId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegenerationIdCopyWith<$Res> {
  factory $RegenerationIdCopyWith(
          RegenerationId value, $Res Function(RegenerationId) then) =
      _$RegenerationIdCopyWithImpl<$Res, RegenerationId>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$RegenerationIdCopyWithImpl<$Res, $Val extends RegenerationId>
    implements $RegenerationIdCopyWith<$Res> {
  _$RegenerationIdCopyWithImpl(this._value, this._then);

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
abstract class _$$RegenerationIdImplCopyWith<$Res>
    implements $RegenerationIdCopyWith<$Res> {
  factory _$$RegenerationIdImplCopyWith(_$RegenerationIdImpl value,
          $Res Function(_$RegenerationIdImpl) then) =
      __$$RegenerationIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$RegenerationIdImplCopyWithImpl<$Res>
    extends _$RegenerationIdCopyWithImpl<$Res, _$RegenerationIdImpl>
    implements _$$RegenerationIdImplCopyWith<$Res> {
  __$$RegenerationIdImplCopyWithImpl(
      _$RegenerationIdImpl _value, $Res Function(_$RegenerationIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$RegenerationIdImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RegenerationIdImpl implements _RegenerationId {
  const _$RegenerationIdImpl({required this.value});

  @override
  final int value;

  @override
  String toString() {
    return 'RegenerationId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegenerationIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegenerationIdImplCopyWith<_$RegenerationIdImpl> get copyWith =>
      __$$RegenerationIdImplCopyWithImpl<_$RegenerationIdImpl>(
          this, _$identity);
}

abstract class _RegenerationId implements RegenerationId {
  const factory _RegenerationId({required final int value}) =
      _$RegenerationIdImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$RegenerationIdImplCopyWith<_$RegenerationIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
