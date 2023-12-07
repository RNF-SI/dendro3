// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'arbreMesure_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ArbreMesureList {
  List<ArbreMesure> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArbreMesureListCopyWith<ArbreMesureList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArbreMesureListCopyWith<$Res> {
  factory $ArbreMesureListCopyWith(
          ArbreMesureList value, $Res Function(ArbreMesureList) then) =
      _$ArbreMesureListCopyWithImpl<$Res, ArbreMesureList>;
  @useResult
  $Res call({List<ArbreMesure> values});
}

/// @nodoc
class _$ArbreMesureListCopyWithImpl<$Res, $Val extends ArbreMesureList>
    implements $ArbreMesureListCopyWith<$Res> {
  _$ArbreMesureListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_value.copyWith(
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<ArbreMesure>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ArbreMesureListCopyWith<$Res>
    implements $ArbreMesureListCopyWith<$Res> {
  factory _$$_ArbreMesureListCopyWith(
          _$_ArbreMesureList value, $Res Function(_$_ArbreMesureList) then) =
      __$$_ArbreMesureListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ArbreMesure> values});
}

/// @nodoc
class __$$_ArbreMesureListCopyWithImpl<$Res>
    extends _$ArbreMesureListCopyWithImpl<$Res, _$_ArbreMesureList>
    implements _$$_ArbreMesureListCopyWith<$Res> {
  __$$_ArbreMesureListCopyWithImpl(
      _$_ArbreMesureList _value, $Res Function(_$_ArbreMesureList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_ArbreMesureList(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<ArbreMesure>,
    ));
  }
}

/// @nodoc

class _$_ArbreMesureList extends _ArbreMesureList {
  const _$_ArbreMesureList({required final List<ArbreMesure> values})
      : _values = values,
        super._();

  final List<ArbreMesure> _values;
  @override
  List<ArbreMesure> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'ArbreMesureList(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArbreMesureList &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArbreMesureListCopyWith<_$_ArbreMesureList> get copyWith =>
      __$$_ArbreMesureListCopyWithImpl<_$_ArbreMesureList>(this, _$identity);
}

abstract class _ArbreMesureList extends ArbreMesureList {
  const factory _ArbreMesureList({required final List<ArbreMesure> values}) =
      _$_ArbreMesureList;
  const _ArbreMesureList._() : super._();

  @override
  List<ArbreMesure> get values;
  @override
  @JsonKey(ignore: true)
  _$$_ArbreMesureListCopyWith<_$_ArbreMesureList> get copyWith =>
      throw _privateConstructorUsedError;
}
