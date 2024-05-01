// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'placette_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlacetteList {
  List<Placette> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlacetteListCopyWith<PlacetteList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlacetteListCopyWith<$Res> {
  factory $PlacetteListCopyWith(
          PlacetteList value, $Res Function(PlacetteList) then) =
      _$PlacetteListCopyWithImpl<$Res, PlacetteList>;
  @useResult
  $Res call({List<Placette> values});
}

/// @nodoc
class _$PlacetteListCopyWithImpl<$Res, $Val extends PlacetteList>
    implements $PlacetteListCopyWith<$Res> {
  _$PlacetteListCopyWithImpl(this._value, this._then);

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
              as List<Placette>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlacetteListImplCopyWith<$Res>
    implements $PlacetteListCopyWith<$Res> {
  factory _$$PlacetteListImplCopyWith(
          _$PlacetteListImpl value, $Res Function(_$PlacetteListImpl) then) =
      __$$PlacetteListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Placette> values});
}

/// @nodoc
class __$$PlacetteListImplCopyWithImpl<$Res>
    extends _$PlacetteListCopyWithImpl<$Res, _$PlacetteListImpl>
    implements _$$PlacetteListImplCopyWith<$Res> {
  __$$PlacetteListImplCopyWithImpl(
      _$PlacetteListImpl _value, $Res Function(_$PlacetteListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$PlacetteListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Placette>,
    ));
  }
}

/// @nodoc

class _$PlacetteListImpl extends _PlacetteList {
  const _$PlacetteListImpl({required final List<Placette> values})
      : _values = values,
        super._();

  final List<Placette> _values;
  @override
  List<Placette> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'PlacetteList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlacetteListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlacetteListImplCopyWith<_$PlacetteListImpl> get copyWith =>
      __$$PlacetteListImplCopyWithImpl<_$PlacetteListImpl>(this, _$identity);
}

abstract class _PlacetteList extends PlacetteList {
  const factory _PlacetteList({required final List<Placette> values}) =
      _$PlacetteListImpl;
  const _PlacetteList._() : super._();

  @override
  List<Placette> get values;
  @override
  @JsonKey(ignore: true)
  _$$PlacetteListImplCopyWith<_$PlacetteListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
