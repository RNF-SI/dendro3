// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'corCyclePlacette_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CorCyclePlacetteList {
  List<CorCyclePlacette> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CorCyclePlacetteListCopyWith<CorCyclePlacetteList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorCyclePlacetteListCopyWith<$Res> {
  factory $CorCyclePlacetteListCopyWith(CorCyclePlacetteList value,
          $Res Function(CorCyclePlacetteList) then) =
      _$CorCyclePlacetteListCopyWithImpl<$Res, CorCyclePlacetteList>;
  @useResult
  $Res call({List<CorCyclePlacette> values});
}

/// @nodoc
class _$CorCyclePlacetteListCopyWithImpl<$Res,
        $Val extends CorCyclePlacetteList>
    implements $CorCyclePlacetteListCopyWith<$Res> {
  _$CorCyclePlacetteListCopyWithImpl(this._value, this._then);

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
              as List<CorCyclePlacette>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CorCyclePlacetteListCopyWith<$Res>
    implements $CorCyclePlacetteListCopyWith<$Res> {
  factory _$$_CorCyclePlacetteListCopyWith(_$_CorCyclePlacetteList value,
          $Res Function(_$_CorCyclePlacetteList) then) =
      __$$_CorCyclePlacetteListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CorCyclePlacette> values});
}

/// @nodoc
class __$$_CorCyclePlacetteListCopyWithImpl<$Res>
    extends _$CorCyclePlacetteListCopyWithImpl<$Res, _$_CorCyclePlacetteList>
    implements _$$_CorCyclePlacetteListCopyWith<$Res> {
  __$$_CorCyclePlacetteListCopyWithImpl(_$_CorCyclePlacetteList _value,
      $Res Function(_$_CorCyclePlacetteList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_CorCyclePlacetteList(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<CorCyclePlacette>,
    ));
  }
}

/// @nodoc

class _$_CorCyclePlacetteList extends _CorCyclePlacetteList {
  const _$_CorCyclePlacetteList({required final List<CorCyclePlacette> values})
      : _values = values,
        super._();

  final List<CorCyclePlacette> _values;
  @override
  List<CorCyclePlacette> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'CorCyclePlacetteList(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CorCyclePlacetteList &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CorCyclePlacetteListCopyWith<_$_CorCyclePlacetteList> get copyWith =>
      __$$_CorCyclePlacetteListCopyWithImpl<_$_CorCyclePlacetteList>(
          this, _$identity);
}

abstract class _CorCyclePlacetteList extends CorCyclePlacetteList {
  const factory _CorCyclePlacetteList(
      {required final List<CorCyclePlacette> values}) = _$_CorCyclePlacetteList;
  const _CorCyclePlacetteList._() : super._();

  @override
  List<CorCyclePlacette> get values;
  @override
  @JsonKey(ignore: true)
  _$$_CorCyclePlacetteListCopyWith<_$_CorCyclePlacetteList> get copyWith =>
      throw _privateConstructorUsedError;
}
