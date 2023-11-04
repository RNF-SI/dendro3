// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'nomenclature_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NomenclatureList {
  List<Nomenclature> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NomenclatureListCopyWith<NomenclatureList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NomenclatureListCopyWith<$Res> {
  factory $NomenclatureListCopyWith(
          NomenclatureList value, $Res Function(NomenclatureList) then) =
      _$NomenclatureListCopyWithImpl<$Res, NomenclatureList>;
  @useResult
  $Res call({List<Nomenclature> values});
}

/// @nodoc
class _$NomenclatureListCopyWithImpl<$Res, $Val extends NomenclatureList>
    implements $NomenclatureListCopyWith<$Res> {
  _$NomenclatureListCopyWithImpl(this._value, this._then);

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
              as List<Nomenclature>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NomenclatureListCopyWith<$Res>
    implements $NomenclatureListCopyWith<$Res> {
  factory _$$_NomenclatureListCopyWith(
          _$_NomenclatureList value, $Res Function(_$_NomenclatureList) then) =
      __$$_NomenclatureListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Nomenclature> values});
}

/// @nodoc
class __$$_NomenclatureListCopyWithImpl<$Res>
    extends _$NomenclatureListCopyWithImpl<$Res, _$_NomenclatureList>
    implements _$$_NomenclatureListCopyWith<$Res> {
  __$$_NomenclatureListCopyWithImpl(
      _$_NomenclatureList _value, $Res Function(_$_NomenclatureList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_NomenclatureList(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Nomenclature>,
    ));
  }
}

/// @nodoc

class _$_NomenclatureList extends _NomenclatureList {
  const _$_NomenclatureList({required final List<Nomenclature> values})
      : _values = values,
        super._();

  final List<Nomenclature> _values;
  @override
  List<Nomenclature> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'NomenclatureList(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NomenclatureList &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NomenclatureListCopyWith<_$_NomenclatureList> get copyWith =>
      __$$_NomenclatureListCopyWithImpl<_$_NomenclatureList>(this, _$identity);
}

abstract class _NomenclatureList extends NomenclatureList {
  const factory _NomenclatureList({required final List<Nomenclature> values}) =
      _$_NomenclatureList;
  const _NomenclatureList._() : super._();

  @override
  List<Nomenclature> get values;
  @override
  @JsonKey(ignore: true)
  _$$_NomenclatureListCopyWith<_$_NomenclatureList> get copyWith =>
      throw _privateConstructorUsedError;
}
