// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arbre_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ArbreId {
  int get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArbreIdCopyWith<ArbreId> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArbreIdCopyWith<$Res> {
  factory $ArbreIdCopyWith(ArbreId value, $Res Function(ArbreId) then) =
      _$ArbreIdCopyWithImpl<$Res, ArbreId>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class _$ArbreIdCopyWithImpl<$Res, $Val extends ArbreId>
    implements $ArbreIdCopyWith<$Res> {
  _$ArbreIdCopyWithImpl(this._value, this._then);

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
abstract class _$$ArbreIdImplCopyWith<$Res> implements $ArbreIdCopyWith<$Res> {
  factory _$$ArbreIdImplCopyWith(
          _$ArbreIdImpl value, $Res Function(_$ArbreIdImpl) then) =
      __$$ArbreIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$ArbreIdImplCopyWithImpl<$Res>
    extends _$ArbreIdCopyWithImpl<$Res, _$ArbreIdImpl>
    implements _$$ArbreIdImplCopyWith<$Res> {
  __$$ArbreIdImplCopyWithImpl(
      _$ArbreIdImpl _value, $Res Function(_$ArbreIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ArbreIdImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ArbreIdImpl implements _ArbreId {
  const _$ArbreIdImpl({required this.value});

  @override
  final int value;

  @override
  String toString() {
    return 'ArbreId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArbreIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArbreIdImplCopyWith<_$ArbreIdImpl> get copyWith =>
      __$$ArbreIdImplCopyWithImpl<_$ArbreIdImpl>(this, _$identity);
}

abstract class _ArbreId implements ArbreId {
  const factory _ArbreId({required final int value}) = _$ArbreIdImpl;

  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$ArbreIdImplCopyWith<_$ArbreIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
