// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dispositif_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DispositifList {
  List<Dispositif> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DispositifListCopyWith<DispositifList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DispositifListCopyWith<$Res> {
  factory $DispositifListCopyWith(
          DispositifList value, $Res Function(DispositifList) then) =
      _$DispositifListCopyWithImpl<$Res, DispositifList>;
  @useResult
  $Res call({List<Dispositif> values});
}

/// @nodoc
class _$DispositifListCopyWithImpl<$Res, $Val extends DispositifList>
    implements $DispositifListCopyWith<$Res> {
  _$DispositifListCopyWithImpl(this._value, this._then);

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
              as List<Dispositif>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DispositifListCopyWith<$Res>
    implements $DispositifListCopyWith<$Res> {
  factory _$$_DispositifListCopyWith(
          _$_DispositifList value, $Res Function(_$_DispositifList) then) =
      __$$_DispositifListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Dispositif> values});
}

/// @nodoc
class __$$_DispositifListCopyWithImpl<$Res>
    extends _$DispositifListCopyWithImpl<$Res, _$_DispositifList>
    implements _$$_DispositifListCopyWith<$Res> {
  __$$_DispositifListCopyWithImpl(
      _$_DispositifList _value, $Res Function(_$_DispositifList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_DispositifList(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Dispositif>,
    ));
  }
}

/// @nodoc

class _$_DispositifList extends _DispositifList {
  const _$_DispositifList({required final List<Dispositif> values})
      : _values = values,
        super._();

  final List<Dispositif> _values;
  @override
  List<Dispositif> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'DispositifList(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DispositifList &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DispositifListCopyWith<_$_DispositifList> get copyWith =>
      __$$_DispositifListCopyWithImpl<_$_DispositifList>(this, _$identity);
}

abstract class _DispositifList extends DispositifList {
  const factory _DispositifList({required final List<Dispositif> values}) =
      _$_DispositifList;
  const _DispositifList._() : super._();

  @override
  List<Dispositif> get values;
  @override
  @JsonKey(ignore: true)
  _$$_DispositifListCopyWith<_$_DispositifList> get copyWith =>
      throw _privateConstructorUsedError;
}
